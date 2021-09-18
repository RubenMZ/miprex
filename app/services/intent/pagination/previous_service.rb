module Intent
  module Pagination
    class PreviousService < Intent::BaseService
      def execute
        {
          followupEventInput: {
            name: pagination_context[:current_intent],
            parameters: {
              page: pagination_params[:page] - 1,
              per: pagination_params[:per]
            }
          }
        }
      end
    end
  end
end
