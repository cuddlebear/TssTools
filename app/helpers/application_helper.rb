module ApplicationHelper
  def status_badge(value=0, text="")
    case value
      when 0
        badge = ""
        icon = "icon-asterisk icon-white"
        title = "New"
        status_text = "New"
      when 1
        badge = ""
        icon = "icon-question-sign icon-white"
        title = "Unknown"
        status_text ="?"
      when 2
        badge = ""
        icon = "icon-question-sign icon-white"
        title = "Maintenance"
        status_text = "Maint."
      when 3
        badge = "badge-warning"
        icon = "icon-bell icon-white"
        title = "Warning"
        status_text = "Warn."
      when 4
        badge = "badge-important"
        icon = "icon-bullhorn icon-white"
        title = "Critical"
        status_text = "Crit."
      when 5
        badge = "badge-success"
        icon = "icon-ok-sign icon-white"
        title = "ok"
        status_text ="OK"
      else
        badge = ""
        icon = "icon-question-sign icon-white"
        title = "unknown"
        status_text = "?"
    end

    content_tag(:span, class: "badge " + badge , title: title) do
      content_tag(:i, class: icon, title: title ) do
      end + " " + status_text + text
    end
  end

  def icon_boolean(value, text="")
    if value
      icon = "icon-ok"
      title = "true"
    else
      icon = "icon-remove"
      title = "false"
    end
    content_tag(:i, class: icon, title: title ) do
    end +
        text
  end

  def  property_select (field_name, field_value, property_code)
    print collection_select(:page, :status, Property.where("property_group_id = ?",1), :id, :name, {:prompt => true}, class:"input-small")
  end

end
