class WebhookController < ApplicationController

  def webhook
    response = Webhook::WebhookService.execute(params)
    render json: response
  end
end

