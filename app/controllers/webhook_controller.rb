class WebhookController < ApplicationController

  def webhook
    render json: {
      "fulfillmentMessages": [
        {
          "text": {
            "text": [
              "Text response from webhook"
            ]
          }
        }
      ]
    }
  end
end
