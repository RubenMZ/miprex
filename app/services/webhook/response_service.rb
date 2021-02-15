module Webhook
  class ResponseService
    class << self
      def execute(array)
        {
          fulfillmentMessages: build_messages(array)
        }
      end

      def build_messages(array)
        array.each { |item| message(item) }
      end

      def message(data)
        # define it in each response service
      end

      def card_messages(array)
        {
          fulfillmentMessages: array.map { |i| card_message(i) }
        }
      end

      def card_message(data)
        {
          card: {
            title: data[:title],
            subtitle: data[:subtitle],
            imageUri: data[:image],
            buttons: [
              {
                text: 'Button',
                postback: 'https://www.google.es'
              }
            ]
          }
        }
      end

      def text_message(data)
        {
          text: {
            text: [
              data[:text]
            ]
          }
        }
      end
    end
  end
end