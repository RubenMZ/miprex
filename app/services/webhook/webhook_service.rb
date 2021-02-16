module Webhook
  class WebhookService
    def self.execute(params)
      response = Webhook::IntentService.execute(params)
      Webhook::ResponseService.execute(response)
    end

    private

    def source
      params[:source]
    end
  end
end