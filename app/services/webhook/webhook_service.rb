module Webhook
  class WebhookService
    class << self
      def execute(params)
        response = Webhook::IntentService.execute(params)
        Webhook::ResponseService.execute(response)
      end

      private

      def source
        params[:source]
      end
    end
  end
end
