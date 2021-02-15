module Webhook
  class IntentService
    class << self
      def execute(params)
        initiate(params)
        @service.execute(params)
      end

      private

      def initiate(params)
        @intent = intent_name(params)
        @service = intents_correspondence[@intent.to_sym]
      end

      def intent_name(params)
        params[:queryResult][:action]
      end

      def intents_correspondence
        {
          'products.index': Intent::ProductsIndexService,
        }
      end
    end
  end
end