module Webhook
  class WebhookService
    class << self
      def run(params)
        response = Webhook::IntentService.run(params)
        Webhook::ResponseService.run(response)
      end

      private

      def source
        params[:source]
      end
    end
  end
end
