module ApplicationHelper
  def page_title(title)
    content_for :page_title do
      title
    end
  end

  def bootstrap_class_for(flash_type)
    case flash_type
      when "success"
        "alert-success"   # Green
      when "error"
        "alert-danger" 
      when :error, :validation_errors
        "alert-error"  
      when "alert"
        "alert-warning"   # Yellow
      when "notice"
        "alert-info"      # Blue
      else
        flash_type.to_s
    end
  end
end
  