# frozen_string_literal: true

module ApplicationHelper
  def display_links(ary)
    links = ary.collect do |x|
      link_to_unless_current x.camelcase, send("#{x.underscore}_path")
    end
    safe_join(links, ' | ')
  end

  def function(index)
    return 'dominant' if index.zero?
    return 'auxiliary' if index == 1
    return 'tertiary' if index == 2

    'inferior'
  end

  def show(id, name, path, current)
    if current.include?(id)
      link_to 'Hide', type_path(path, format: current.without(id).join, anchor: id)
    else
      link_to name, type_path(path, format: [*current, id].join, anchor: id)
    end
  end
end
