module Autumn
  class Injector

    attr_accessor :context

    def initialize(context_config)
      @context = Context.new(context_config)
    end

    def inject_context!
      @context.each do |bean|
        if bean.needs_injection?
          
          class <<bean.bean_class
            def new_with_injector(*args)
              object_to_inject = new_without_injector(*args)
              object_to_inject.do_injection!
              return object_to_inject
            end

            alias_method_chain :new, :injector
          end
          
          fragment_code = bean.setter_injections.inject("") do |fragment, setter|
            fragment << "send(:#{setter.name}=, #{setter.value})\n"
          end

          puts fragment_code

          injection_code = <<-EOF
            def do_injection!
              puts "> doing injection ..."
              #{fragment_code}
            end
          EOF
          
          bean.bean_class.class_eval(injection_code, "injector")
          
        end
      end
    end

  end
end