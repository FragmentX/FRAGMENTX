module ApplicationHelper
  # Determines flash alerts css class based on the level parameter
  def flash_class(level)
    case level
    when 'notice' then 'info'
    when 'success' then 'success'
    when 'alert' then 'warning'
    else 'danger'
    end
  end
end
