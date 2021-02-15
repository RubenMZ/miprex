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
        @products.map do |product|
          {
            title: product.name,
            subtitle: description(product),
            imageUri: 'https://www.vinotecadelalto.cl/wp-content/uploads/2019/11/test-product.png'
          }
        end
      end

      def description(product)
        'test'
      end

      def generate_response(data)
        Webhook::ResponseService.card_messages(data)
      end
    end
  end
end