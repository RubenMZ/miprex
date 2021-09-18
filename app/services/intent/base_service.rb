module Intent
  class BaseService
    class << self
      def run(params={})
        instance = new(params)

        instance.execute
      end
    end

    attr_reader :service, :params

    def initialize(params)
      @params = params
    end

    def execute
      raise AbstractMethodError, __method__
    end

    def intent
      params[:queryResult][:action]
    end

    def filter_params
      params[:queryResult][:parameters]
    end

    def input_contexts
      params[:queryResult][:inputContexts]
    end

    def pagination_context
      @pagination_context ||= input_contexts&.find { |c| c['name'].include? 'pagination' }
    end

    def input_pagination_parameters
      pagination_context.present? ? pagination_context[:parameters] : {}
    end

    def pagination_params
      {
        page: input_pagination_parameters[:page] || 1,
        per: input_pagination_parameters[:per] || 10
      }
    end

    def output_contexts
      [pagination_context&.merge(parameters: output_pagination_parameters)]
    end

    def output_pagination_parameters
      input_pagination_parameters.merge(
        current_intent: intent,
        page: pagination_params[:page],
        per: pagination_params[:per]
      )
    end
  end
end
