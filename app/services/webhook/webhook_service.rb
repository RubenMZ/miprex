module Webhook
  class WebhookService
    def self.execute(params)
      Webhook::IntentService.execute(params)
      # Webhook::ResponseService.execute(params)
    end

    private

    def source
      params[:source]
    end
  end
end