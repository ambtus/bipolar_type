# frozen_string_literal: true

module TypeHelper
  def link(concept, color)
    link_to concept.link, send("#{concept.class.name.downcase}_path", concept.path, format: color)
  end

  def green(concept)
    safe_join(['<span style="background-color:green;font-size:xx-large">'.html_safe,
               link(concept, 'green'),
               '</span>'.html_safe])
  end

  def yellow(concept)
    safe_join(['<span style="background-color:yellow; font-size:x-large">'.html_safe,
               concept.link,
               '</span>'.html_safe])
  end

  def red(concept)
    safe_join(['<span style="background-color:red;font-size:large">'.html_safe,
               link(concept, 'red'),
               '</span>'.html_safe])
  end
end
