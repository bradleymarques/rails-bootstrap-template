module ApplicationHelper
  def toast_klass(flash_message_klass)
    case flash_message_klass.to_sym
    when :alert
      "toast align-items-center bg-danger border-0"
    else
      "toast align-items-center bg-primary border-0"
    end
  end
end
