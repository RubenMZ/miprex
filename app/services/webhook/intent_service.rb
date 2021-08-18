module Webhook
  class IntentService
    class << self
      attr_reader :params

      def run(params)
        initialize(params)
        service.run(params)
      end

      private

      def initialize(params)
        @params = params
      end

      def service
        *modules, action = intent.split('.')

        modules = modules.map(&:classify).join('::')
        action = action.classify

        "Intent::#{modules}::#{action}Service".constantize
      end

      def intent
        params[:queryResult][:action]
      end
    end
  end
end
