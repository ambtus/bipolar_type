# frozen_string_literal: true

module TypeHelper
  def green(behavior)
    safe_join(['<span style="background-color:green;font-size:xx-large">'.html_safe,
               behavior.link,
               '</span>'.html_safe])
  end

  def yellow(behavior)
    safe_join(['<span style="background-color:yellow; font-size:x-large">'.html_safe,
               behavior.link,
               '</span>'.html_safe])
  end

  def red(behavior)
    safe_join(['<span style="background-color:red;font-size:large">'.html_safe,
               behavior.link,
               '</span>'.html_safe])
  end
end
