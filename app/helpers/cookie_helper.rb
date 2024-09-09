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
    symbolic = cookies['MBTI'].present? ? nil : behavior.mbti
    trigger = cookies['triggers'].present? ? nil : behavior.trigger
    response = cookies['responses'].present? ? nil : behavior.respond
    action = cookies['actions'].present? ? nil : behavior.act
    example = cookies['examples'].present? ? nil : cookies[behavior.mbti] || @words[behavior.mbti]

    words = [symbolic, trigger, response, action, example].compact
    case words.length
    when 0
      'respond'
    when 1
      words.first
    when 2
      [words.first.colon, words.second].to_phrase
    when 3
      [words.first.colon, words.second, words.third.wrap].to_phrase
    when 4
      [words.first.colon, words.second, words.third.wrap, words.fourth.sqwrap].to_phrase
    when 5
      [words.first.colon, words.second, '=>', words.third, words.fourth.wrap, words.fifth.sqwrap].to_phrase
    end
  end

end
