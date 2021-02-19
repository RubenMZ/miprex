module Intent
  class ProductsIndexService
    class << self
      attr_reader :params

      def execute(params)
        initiate(params)
        products = build_data
        generate_response(products)
      end

      private

      def initiate(params)
        @params = params
        @products = Product.search_by_name(filter_params)
      end

      def filter_params
        params[:any]
      end

      def build_data
        {
          subtitle: description,
        }
      end

      def description
        "#{I18n.t('products.header')}\n\n#{products_description}"
      end

      def products_description
        @products.each_with_object('') do |product, text|
          text << "#{product_name(product)}\n#{prices_description(product)}\n"
        end
      end

      def product_name(product)
        I18n.t('products.name', product_name: product.name)
      end

      def prices_description(product)
        product.ordered_last_prices.each.with_index.each_with_object('') do |(price, index), text|
          text << "    #{I18n.t('products.medals')[index]} #{price_description(product, price)}\n"
        end
      end

      def price_description(product, price)
        params = {
          supermarket_name: price.supermarket.name,
          price: round_decimals(price.value),
          unit_price: unit_price(product, price),
          unit: product.unit
        }
        I18n.t('products.price', params)
      end

      def unit_price(product, price)
        round_decimals(price.value / product.quantity)
      end

      def round_decimals(value)
        sprintf('%.2f', value)
      end

      def generate_response(data)
        Webhook::ResponseService.card_message(data)
      end
    end
  end
end