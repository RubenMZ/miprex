module Intent
  module Pagination
    class NextService < Intent::BaseService
      def execute
        {
          followupEventInput: {
            name: 'product.index',
            parameters: {
              page: pagination_params[:page] + 1,
              per: pagination_params[:per]
            }
          }
        }
      end
    end
  end
end
