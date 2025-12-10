# frozen_string_literal: true

module ApplicationHelper
  def display_links(ary)
    links = ary.collect do |x|
      link_to_unless_current x.camelcase, send("#{x.underscore}_path")
    end
    safe_join(links, ' | ')
  end

  def display(thing, a_lot: false)
    first = "<a href='#' class='hover-link'>".html_safe
    middle = "<span class='popup'>".html_safe
    last = '</span></a>'.html_safe
    text = thing.short_words
    text = text.a_lot if a_lot
    safe_join([first, thing, middle, text, last])
  end

  def link_to_concept(concept, a_lot: false)
    if concept.is_a? Class
      link_to concept.title, concept.name.downcase.pluralize.to_s
    else
      text = concept.title
      text = concept.title.a_lot if a_lot
      link_to text, send("#{concept.class.name.downcase}_path", concept.path)
    end
  end

  def display_and(ary)
    displays = ary.collect { |x| display x }
    safe_join(
      [displays[0], ', ',
       displays[1], ', ',
       displays[2], ', ',
       displays[3]]
    )
  end
end
