# frozen_string_literal: true

module TypeHelper
  def generic(concept)
    (link_to concept.link, send("#{concept.class.name.downcase}_path", concept.path))
  end

  def green(concept)
    safe_join(['<span style="background-color:green;font-size:xx-large">'.html_safe,
               generic(concept),
               '</span>'.html_safe])
  end

  def yellow(concept)
    safe_join(['<span style="background-color:yellow; font-size:x-large">'.html_safe,
               generic(concept),
               '</span>'.html_safe])
  end

  def red(concept)
    safe_join(['<span style="background-color:red;font-size:large">'.html_safe,
               generic(concept),
               '</span>'.html_safe])
  end

  def short_link_to(concept)
    link_to concept.short_words, send("#{concept.class.name.downcase}_path", concept.path)
  end

  def link_and(ary)
    links = ary.collect { |x| short_link_to x }
    safe_join(
      [links[0], ', ',
       links[1], ', ',
       links[2], ', ',
       links[3]]
    )
  end
end
