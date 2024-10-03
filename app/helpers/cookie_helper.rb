module CookieHelper
  def manic(function, td=false)
    format(function.cookies.first, td)
  end

  def depressed(function, td=false)
    format(function.cookies.second, td)
  end

  def format(key, td=false)
    function = Function.send(key.first)
    css = cookies['function_colors'].present? ? nil : function.css
    mbti = cookies[:MBTI] ?  nil : key.colon
    my_verbs = cookies[key] || @verbs[key]
    verbs = cookies['changed_verbs'].present? ? function.send(key.second) : my_verbs
    phrase = [mbti, verbs].to_phrase
    if css.blank?
      if td
        "<td>phrase</td>"
      else
        phrase
      end
    elsif td
      "<td class=#{css}>#{phrase}</td>"
    else
      "<span class=#{css}>#{phrase}</span>"
    end.html_safe
  end

end
