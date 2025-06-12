module ApplicationHelper

  def display(subtype)
    cookies[subtype.tla] || subtype.realm.send(subtype.attitude.action)
  end

  def nbsp
    '&nbsp;'.html_safe
  end

end
