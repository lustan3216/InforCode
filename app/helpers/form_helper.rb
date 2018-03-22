module FormHelper
  class FormBuilder < ActionView::Helpers::FormBuilder

    def label(method, text = nil, options = {}, &block)
      validator = object._validators[method][0]

      if validator && validator.attributes.include?(method)
        options.merge!(class: 'require')
      end

      super method, text, options, &block
    end
  end
end