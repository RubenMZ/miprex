module Intent
  class ProductsService
    class << self
      attr_reader :params, :products

      def execute(params)
        initiate(params)

        if products.count == 1
          Intent::ProductsShowService.execute(products.first)
        elsif products.count > 1
          Intent::ProductsIndexService.execute(products)
        else
          {}
        end
      end

      private

      def initiate(params)
        @params = params
        @products = Product.search_by_name(filter_params)
      end

      def filter_params
        params[:any]
      end
    end
  end
end