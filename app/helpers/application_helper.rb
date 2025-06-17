module ApplicationHelper

  def display(subtype)
    cookies[subtype.tla] || subtype.action
  end

  def nbsp
    '&nbsp;'.html_safe
  end

  def circle
    '&orarr;'.html_safe
  end
end
