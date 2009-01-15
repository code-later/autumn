require 'yaml'

module Autumn
  class Context
    include Enumerable
  
    def initialize(context_config)
      data = YAML.load_file context_config
      @beans = data.inject([]) do |array, single_data|
        array << Bean.new(self, single_data)
      end
    end
  
    def each
      @beans.each { |bean| yield bean }
    end
  end
end