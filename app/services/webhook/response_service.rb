module Webhook
  class ResponseService
    class << self
      def run(fulfillment_messages: [], output_contexts: [])
        {
          fulfillmentMessages: fulfillment_messages,
          outputContexts: output_contexts
        }
      end

      def card_message(data)
        {
          card: {
            title: data[:title],
            subtitle: data[:subtitle],
            imageUri: data[:image],
            buttons: [] # [{text: 'Link (soon)', postback: 'https://example.com'}]
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
