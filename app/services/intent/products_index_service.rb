module Intent
  class ProductsIndexService
    class << self
      def execute(params)
        initiate(params)
        products = build_data
        generate_response(products)
      end

      private

      def initiate(params)
        @products = Product.all
      end

      def build_data
        {
          subtitle: description,
          image: 'https://www.vinotecadelalto.cl/wp-content/uploads/2019/11/test-product.png'
        }
      end

      def description
        text = "#{I18n.t('products.header')}\n\n"
        @products.each { |p| text += product_description(p) }
        text
      end

      def product_description(product)
        "#{product_name(product)}\n#{prices_description(product)}\n"
      end

      def product_name(product)
        I18n.t('products.name', product_name: product.name)
      end

      def prices_description(product)
        text = ""
        product.ordered_last_prices.each_with_index do |price, index|
          text += "\t#{I18n.t('products.medals')[index]} #{price_description(product, price)}\n"
        end
        text
      end

      def price_description(product, price)
        params = {
          supermarket_name: price.supermarket.name,
          price: price.value,
          unit_price: unit_price(product, price),
          unit: product.unit
        }
        I18n.t('products.price', params)
      end

      def unit_price(product, price)
        (price.value / product.quantity).round(2)
      end

      def generate_response(data)
        Webhook::ResponseService.card_message(data)
      end
    end
  end
end