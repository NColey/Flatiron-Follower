module ApplicationHelper
  def bootstrap_class_for(type)
    { success: 'alert-success',
      error:   'alert-danger',
      alert:   'alert-warning',
      notice:  'alert-info'
    }[type.to_sym] || type.to_s
  end
end
