# frozen_string_literal: true

module ApplicationHelper
  def display_links(ary)
    links = ary.collect do |x|
      link_to_unless_current x.camelcase, send("#{x.underscore}_path")
    end
    safe_join(links, ' | ')
  end

  def function(index)
    return 'inferior' if index.zero?
    return 'tertiary' if index == 1

    'auxiliary'
  end
end
