# frozen_string_literal: true

module ApplicationHelper
  def display(subtype)
    cookies[subtype.tla] || subtype.action
  end

  def display_links(ary)
    links = ary.collect do |x|
      link_to_unless_current x.camelcase, send("#{x.underscore}_path")
    end
    safe_join(links, ' | ')
  end
end
