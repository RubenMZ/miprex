class WebhookController < ApplicationController
  def webhook
    response = Webhook::WebhookService.run(params)
    render json: response
  end
end
