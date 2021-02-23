module Intent
  class ProductsShowService
    class << self
      attr_reader :product

      def execute(product)
        initiate(product)
        data = build_data
        generate_response(data)
      end

      private

      def initiate(product)
        @product = product
      end

      def build_data
        {
          subtitle: description,
          image: product.image_url
        }
      end

      def description
        "#{product_name}\n#{prices_description}\n"
      end

      def product_name
        I18n.t('products.index.name', product_name: product.name)
      end

      def prices_description
        prices.each_with_object('') do |price, text|
          text << "    #{price_description(product, price)}\n"
        end
      end

      def price_description(product, price)
        params = {
          supermarket_name: price.supermarket.name,
          price: round_decimals(price.value),
          unit_price: unit_price(product, price),
          unit: product.unit
        }
        I18n.t('products.index.price', params)
      end

      def prices
        @prices ||= product.ordered_last_prices
      end

      def unit_price(product, price)
        round_decimals(price.value / product.quantity)
      end

      def round_decimals(value)
        format('%.2f', value)
      end

      def generate_response(data)
        Webhook::ResponseService.card_message(data)
      end
    end
  end
end
