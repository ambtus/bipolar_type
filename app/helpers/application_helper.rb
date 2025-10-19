# frozen_string_literal: true

module ApplicationHelper
  def display_links(ary)
    links = ary.collect do |x|
      link_to_unless_current x.camelcase, send("#{x.underscore}_path")
    end
    safe_join(links, ' | ')
  end

  def behavior_link(realm, action)
    behavior = realm + Attitude.find(action)
    link = link_to behavior.episode, episode_path(behavior.path)
    safe_join([link, "#{behavior.definition.too_much.s} without #{behavior.flip.definition.enough.ing}"], ': ')
  end

  def display(thing)
    "<a href='#' class='hover-link'>#{thing}<span class='popup'>#{thing.definition}</span></a>".html_safe
  end

  def link_to_concept(x)
    link_to x.link, send("#{x.class.name.downcase}_path", x.path)
  end

  def nbsp(i)
    i.times.collect{'&nbsp;'}.join.html_safe
  end
end
