module Intent
  class ProductsIndexService
    class << self
      attr_reader :products

      def execute(products)
        initiate(products)
        data = build_data
        generate_response(data)
      end

      private

      def initiate(products)
        @products = products
      end

      def build_data
        {
          text: description,
        }
      end

      def description
        "#{I18n.t('products.index.header')}\n\n#{products_description}"
      end

      def products_description
        products.each_with_object('') do |product, text|
          text << "#{product_name(product)}\n#{prices_description(product)}\n"
        end
      end

      def product_name(product)
        I18n.t('products.index.name', product_name: product.name)
      end

      def prices_description(product)
        prices(product).each.with_index.each_with_object('') do |(price, index), text|
          text << "    #{I18n.t('products.index.medals')[index]} #{price_description(product, price)}\n"
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

      def prices(product)
        product.ordered_last_prices[0..2]
      end

      def unit_price(product, price)
        round_decimals(price.value / product.quantity)
      end

      def round_decimals(value)
        sprintf('%.2f', value)
      end

      def generate_response(data)
        Webhook::ResponseService.text_message(data)
      end
    end
  end
end