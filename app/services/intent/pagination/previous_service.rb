module Intent
  module Pagination
    class PreviousService < Intent::BaseService
      def execute
        {
          followupEventInput: {
            name: 'productIndex',
            parameters: {
              any: 'lomo embuchado',
              page: pagination_params[:page] - 1,
              per: pagination_params[:per]
            }
          }
        }
      end
    end
  end
end
