# frozen_string_literal: true

module ApplicationHelper
  def green(behavior)
    safe_join(['<span style="background-color:green;font-size:xx-large">'.html_safe,
               behavior.link,
               '</span>'.html_safe])
  end

  # style="background-color:yellow;
  def yellow(behavior)
    safe_join(['<span font-size:x-large">'.html_safe,
               behavior.link,
               '</span>'.html_safe])
  end

  def red(behavior)
    safe_join(['<span style="background-color:red;font-size:large">'.html_safe,
               behavior.link,
               '</span>'.html_safe])
  end
end
