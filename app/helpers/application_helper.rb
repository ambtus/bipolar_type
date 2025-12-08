# frozen_string_literal: true

module ApplicationHelper
  def display_links(ary)
    links = ary.collect do |x|
      link_to_unless_current x.camelcase, send("#{x.underscore}_path")
    end
    safe_join(links, ' | ')
  end

  def display(thing)
    first = "<a href='#' class='hover-link'>".html_safe
    middle = "<span class='popup'>".html_safe
    last = '</span></a>'.html_safe
    safe_join([first, thing, middle, thing.short_words, last])
  end

  def link_to_concept(concept, full_title: true)
    text = full_title ? concept.title : concept.link
    link_to text, send("#{concept.class.name.downcase}_path", concept.path)
  end

  def display_and_link_to(concept)
    safe_join([display(concept), link_to_concept(concept, full_title: false)], ': ')
  end

  def em_and(ary)
    safe_join(ary, ' <em>and</em> '.html_safe)
  end

  def em_or(ary)
    safe_join(ary, ' <em>or</em> '.html_safe)
  end

  def display_and(ary)
    displays = ary.collect { |x| display x }
    safe_join(
      [displays[0], ', ',
       displays[1], ', ',
       displays[2], ', and ',
       displays[3]]
    )
  end
end
