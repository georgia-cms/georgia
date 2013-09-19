SimpleForm.setup do |config|

  config.wrappers :default, :class => 'control-group', :tag => 'div',  :error_class => 'error',
    :hint_class => :field_with_hint, :error_class => :field_with_errors do |b|

    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly
    b.use :label
    b.use :error, :wrap_with => { :tag => :span, :class => :error }
    b.wrapper :tag => 'div', :class => 'controls' do |ba|
      ba.use :input
      ba.use :hint,  :wrap_with => { :tag => :div, :class => :hint }
      ba.use :error, :wrap_with => { :tag => 'span', :class => 'help-inline' }
    end
  end

  config.default_wrapper = :default
  config.boolean_style = :inline
  config.button_class = 'btn'
  config.error_notification_tag = :div
  config.error_notification_class = 'alert alert-error'
  config.label_class = 'control-label'
  config.browser_validations = false

end
