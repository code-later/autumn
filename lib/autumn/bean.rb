module Autumn
  class Bean
  
    class Setter
    
      attr_reader :context, :name
    
      def initialize(context, setter_data)
        @context = context
        @name = setter_data["name"]
        @value = setter_data["value"]
      end
      
      def value
        if @value =~ /^bean>(.*)$/
          bean = @context.select { |bean| bean.name == $1 }.first
          require bean.name
          return "#{bean.bean_class}.new"
        else
          if @value.kind_of? String
            return "String.new('#{@value}')"
          elsif @value.kind_of? Numeric
            return @value
          else
            return @value
          end
        end
      end
      
    end
  
    attr_reader :name, :setter_injections, :context
  
    def initialize(context, data_from_yaml)
      @context = context
      @name = data_from_yaml["bean"]
      @bean_class = data_from_yaml["bean_class"]
      self.setter_injections = data_from_yaml["setter_injection"]
    end
    
    def needs_injection?
      !!@setter_injections
    end
    
    def bean_class
      Object.const_get(@bean_class)
    end
  
    private 
  
      def setter_injections=(plain_setters)
        if plain_setters.nil?
          @setter_injections = nil
        else
          @setter_injections = plain_setters.inject([]) do |arr, setter_data|
            arr << Setter.new(context, setter_data)
          end
        end
      end
  
  end
end