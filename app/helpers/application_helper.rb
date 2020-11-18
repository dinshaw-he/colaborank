module ApplicationHelper
  def bootstrap_alert_class(str)
    case str
    when 'alert', 'error' then 'danger'
    when 'notice' then 'info'
    else
      'success'
    end
  end
end
