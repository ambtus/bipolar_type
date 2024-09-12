module CookieHelper
  def phase_span(phase, string)
    phase_colors = cookies['phase_colors'].present? ? nil : phase.css
    css = "#{phase_colors}"
    if css.blank?
      "<span>#{string}</span>"
    else
      "<span class=#{css}>#{string}</span>"
    end.html_safe
  end

  def span(behavior)
    phase_colors = cookies['phase_colors'].present? ? nil : behavior.css
    realm_colors = cookies['realm_colors'].present? ? nil : behavior.realm.css
    color = [realm_colors, phase_colors].compact.first
    css = "#{color}"
    if css.blank?
      "<span>#{phrase(behavior)}</span>"
    else
      "<span class=#{css}>#{phrase(behavior)}</span>"
    end.html_safe
  end

  def td(behavior, border=nil, align='center')
    phase_colors = cookies['phase_colors'].present? ? nil : behavior.css
    realm_colors = cookies['realm_colors'].present? ? nil : behavior.realm.css
    if border == 'depends'
      border_class = phase_colors ? nil : 'four_border'
    else
      border_class = border.blank? ? nil : "#{border}_border"
    end
    color = [realm_colors, phase_colors].compact.first
    css = '"' + [color, border_class, align].to_phrase + '"'
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
