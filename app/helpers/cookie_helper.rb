module CookieHelper

  def span(behavior)
    if cookies['colors'].present?
      "<span>#{phrase(behavior)}</span>"
    else
      "<span class=#{behavior.css}>#{phrase(behavior)}</span>"
    end.html_safe
  end

  def td(behavior, border=nil, align='center')
    color_class = cookies['colors'].present? ? nil : behavior.css
    if border == 'depends'
      border_class = color_class ? nil : 'four_border'
    else
      border_class = border.blank? ? nil : "#{border}_border"
    end
    css = '"' + [color_class, border_class, align].to_phrase + '"'
    "<td class=#{css}>#{phrase(behavior)}</td>".html_safe
  end

  def phrase(behavior)
    symbolic = cookies['MBTI'].present? ? nil : behavior.mbti.colon
    general = cookies['general'].present? ? nil : behavior.name
    specific = if cookies['specific'].present?
        nil
      else
        my_word = cookies[behavior.mbti]
        if my_word
          my_word.wrap
        else
          @words[behavior.mbti].wrap
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
