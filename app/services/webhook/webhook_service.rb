module Webhook
  class WebhookService
    class << self
      def run(params)
        fulfillment_messages, output_contexts = Webhook::IntentService.run(params)
        Webhook::ResponseService.run(
          fulfillment_messages: fulfillment_messages,
          output_contexts: output_contexts
        )
      end

      private

      def source
        params[:source]
      end
    end
  end
end
