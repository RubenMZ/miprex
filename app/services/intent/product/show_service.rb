module Intent
  module Product
    class ShowService < Intent::BaseService
      def execute
        product = search_product
        data = build_data(product)
        generate_response(data)
      end

      private

      def search_product
        product_by_id || product_by_name
      end

      def product_by_id
        @product_by_id ||= ::Product.find(filter_params[:id])
      end

      def product_by_name
        @product_by_name ||= ::Product.search_by_name(filter_params[:any]).first
      end

      def build_data(product)
        {
          subtitle: description(product),
          image: product.image_url
        }
      end

      def description(product)
        "#{product_name(product)}\n#{prices_description(product)}\n"
      end

      def product_name(product)
        I18n.t('products.index.name', product_name: product.name)
      end

      def prices_description(product)
        prices(product).each_with_object('') do |price, text|
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

      def prices(product)
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
