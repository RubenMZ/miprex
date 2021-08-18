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
  end
end
