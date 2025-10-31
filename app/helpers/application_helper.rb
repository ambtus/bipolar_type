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
    safe_join([link, "#{behavior.word.too_much.s} without #{behavior.flip.word.enough.ing}"], ': ')
  end

  def display(thing)
    first = "<a href='#' class='hover-link'>"
    middle = "<span class='popup'>"
    last = "</span></a>"
    safe_join(first, thing, middle, thing.title, last)
  end

  def link_to_concept(x)
    link_to x.title, send("#{x.class.name.downcase}_path", x.path)
  end

  def nbsp(i)
    i.times.collect{'&nbsp;'}.join.html_safe
  end

  def em_and(ary)
    safe_join(ary, ' <em>and</em> '.html_safe)
  end

  def em_or(ary)
    safe_join(ary, ' <em>or</em> '.html_safe)
  end
end
