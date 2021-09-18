module Intent
  module Product
    class ShowService < Intent::BaseService
      def execute
        product = search_product

        return if product.blank?

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
        "*#{product.name}*\n#{prices_description(product)}"
      end

      def prices_description(product)
        prices(product).each.with_index.each_with_object('') do |(price, index), text|
          text << "    #{I18n.t('products.index.medals')[index]} ##{price.supermarket.name}\n"
          text << "        #{price_description(product, price)}\n"
          text << "        #{price_updated_at(price)}\n"
        end
      end

      def price_description(product, price)
        params = {
          price: round_decimals(price.value),
          unit_price: unit_price(product, price),
          unit: product.unit
        }
        I18n.t('products.show.price', params)
      end

      def price_updated_at(price)
        I18n.t('products.show.updated_at', {updated_at: price.updated_at.strftime('%d/%m/%Y')})
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
