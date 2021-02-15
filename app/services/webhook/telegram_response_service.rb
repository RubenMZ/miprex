module Webhook
  class TelegramResponseService < ResponseService
    private

    def message(data)
      card_message(data)
    end
  end
end