module CookieHelper
  def manic(function, td=false, state='')
    format(state + function.cookies.first, td)
  end

  def depressed(function, td=false, state='')
    format(state + function.cookies.second, td)
  end

  def format(tla, td=false)
    if tla.length == 3
      function = Function.send(tla.second)
      key = tla.chars[1,2].join
    else
      function = Function.send(tla.first)
      key = tla
    end
    css = cookies['function_colors'].present? ? nil : function.css
    mbti = cookies[:MBTI] ?  nil : tla.colon
    my_words = cookies[key] || @words[key]
    words = cookies['changed_words'].present? ? function.send(key.second) : my_words
    phrase = [mbti, words].to_phrase
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

  def advice(function, attitude)

      css = cookies['state_colors'].present? ? 'bordered' : attitude.css
      "<td class=#{css}>#{phrase(attitude.symbol.first, function, attitude)}</td>".html_safe
  end

  def phrase(state, function, attitude)
    [attitude.episode(function).capitalize.break, (attitude.output? ? manic(function, false, state) : depressed(function, false, state)), attitude.more_or_less].to_safe_phrase
  end

end
