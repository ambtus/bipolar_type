module ApplicationHelper
  def display(subtype)
    cookies[subtype.tla] || subtype.action
  end

  def hide?(subtype)
    if @realm
      :hide unless @realm == subtype.realm
    elsif @attitude
      :hide unless @attitude == subtype.attitude
    end
  end

  def nbsp
    '&nbsp;'.html_safe
  end

  def ordinal(index)
    %w[first second third fourth fifth
       sixth seventh eighth ninth tenth][index] ||
      (index + 1).ordinalize
  end
end
