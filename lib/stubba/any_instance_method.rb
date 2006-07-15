require 'stubba/class_method'

module Stubba

  class AnyInstanceMethod < ClassMethod
  
    def unstub
      remove_new_method
      restore_original_method
      object.any_instance.reset_mocha
    end
   
    def hide_original_method
      object.class_eval "alias_method :#{hidden_method}, :#{method}" if object.method_defined?(method)
    end

    def define_new_method
      object.class_eval "def #{method}(*args, &block); self.class.any_instance.mocha.method_missing(:#{method}, *args, &block); end"
    end

    def remove_new_method
      object.class_eval "remove_method :#{method}"
    end

    def restore_original_method
      object.class_eval "alias_method :#{method}, :#{hidden_method}; remove_method :#{hidden_method}" if object.method_defined?(hidden_method)
    end

  end
  
end