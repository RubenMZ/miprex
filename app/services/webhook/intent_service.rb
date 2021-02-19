module Webhook
  class IntentService
    class << self
      attr_reader :service
      attr_reader :params

      def execute(params)
        initiate(params)
        service.execute(filter_params)
      end

      private

      def initiate(params)
        @params = params
        @service = intents_correspondence[intent]
      end

      def intent
        params[:queryResult][:action].to_sym
      end

      def filter_params
        params[:queryResult][:parameters]
      end

      def intents_correspondence
        {
          'products.index': Intent::ProductsIndexService,
        }
      end
    end
  end
end