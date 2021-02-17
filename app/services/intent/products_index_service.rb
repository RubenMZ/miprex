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
        @supermarkets = Product.first.prices.order('created_at DESC').group_by(&:supermarket_id)
      end

      def build_data
        {
          subtitle: description,
          image: 'https://www.vinotecadelalto.cl/wp-content/uploads/2019/11/test-product.png'
        }
      end

      def description
        text = "#{I18n.t('products.header')}\n"
        @products.map { |p| text += product_description(p) }
        text
      end

      def product_description(product)
        "#{I18n.t('products.name', product_name: product.name)}
        #{prices_description(product)}"
      end

      def prices_description(product)
        text = ""
        product.last_prices.each_with_index.map do |price, index|
            text += "#{I18n.t('products.medals')[index]} #{price_description(product, price)}\n"
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