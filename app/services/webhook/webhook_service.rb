module Webhook
  class WebhookService
    class << self
      def run(params)
        Webhook::IntentService.run(params)

        # In the future will be enabled to supply different sources
        # Webhook::ResponseService.run(
        #   fulfillment_messages: fulfillment_messages,
        #   output_contexts: output_contexts
        # )
      end

      private

      def source
        params[:source]
      end
    end
  end
end
