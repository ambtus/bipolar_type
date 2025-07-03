# frozen_string_literal: true

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

  def display_links(ary)
    links = ary.collect do |x|
      link_to_unless_current x.camelcase, send("#{x.underscore}_path")
    end
    safe_join(links, ' | ')
  end
end
