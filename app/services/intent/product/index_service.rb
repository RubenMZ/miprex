module Intent
  module Product
    class IndexService < Intent::BaseService
      def execute
        products = search_products

        return if products.empty?

        data = build_data(products)

        generate_response(data)
      end

      private

      def search_products
        ::Product.search_by_name(filter_params[:any]) # .paginate(pagination_params)
      end

      def build_data(products)
        {subtitle: description(products)}
      end

      def description(products)
        "#{I18n.t('products.index.header')}\n\n#{products_description(products)}"
      end

      def products_description(products)
        products.each_with_object('') do |product, text|
          text << "#{product_name(product)}\n#{prices_description(product)}\n"
        end
      end

      def product_name(product)
        "#{I18n.t('products.index.name', product_name: product.name)} #{product_command(product)}"
      end

      def product_command(product)
        "/mostrar_#{product.id}"
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
        product.ordered_last_prices[0..2]
      end

      def unit_price(product, price)
        round_decimals(price.value / product.quantity)
      end

      def round_decimals(value)
        format('%.2f', value)
      end

      def generate_response(data)
        {
          fulfillmentMessages: [Webhook::ResponseService.card_message(data)],
          outputContexts: output_contexts
        }
      end
    end
  end
end
