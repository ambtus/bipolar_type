module CookieHelper

  def span(behavior)
    if cookies['colors'] == '1'
      "<span>#{phrase(behavior)}</span>"
    else
      "<span class=#{behavior.css}>#{phrase(behavior)}</span>"
    end.html_safe
  end

  def td(behavior, border=nil, align='center')
    border_class = border.blank? ? nil : "#{border}_border"
    color_class = cookies['colors'] == '1' ? nil : behavior.css
    css = '"' + [color_class, border_class, align].to_phrase + '"'
    "<td class=#{css}>#{phrase(behavior)}</td>".html_safe
  end

  def phrase(behavior)
    symbolic = cookies['MBTI'] == '1' ? nil : behavior.mbti.colon
    general = cookies['general'] == '1' ? nil : behavior.name
    specific = if cookies['specific'] == '1'
        nil
      else
        my_word = cookies[behavior.mbti]
        if my_word
          my_word.wrap
        else
          YAML.load_file('config/my_words.yml')[behavior.mbti].wrap
        end
      end
    words = [symbolic, general, specific].compact
    case words.length
    when 0
      'respond'
    when 1
      words.first.unwrap.unpunctuate
    when 2
      if words.second.wrapped?
        [words.first.unpunctuate, words.second].to_phrase
      else
        [words.first, words.second].to_phrase
      end
    when 3
      [words.first, words.second, words.third].to_phrase
    end
  end

end
