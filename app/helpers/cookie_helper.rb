module CookieHelper

  def css(thing, td=false)
    bordered = td ? 'bordered' : nil
    if thing.is_a?(Phase)
      cookies['phase_colors'].present? ? bordered : "background-color: #{thing.color}"
    elsif thing.is_a? Focus
      cookies['focus_colors'].present? ? bordered : "background-color: #{thing.color}"
    elsif thing.is_a? Problem
      if cookies['phase_colors'].present? && cookies['focus_colors'].present?
        bordered
      elsif cookies['phase_colors'].present?
        "background-color: #{thing.phase.color}"
      elsif cookies['focus_colors'].present?
        "background-color: #{thing.focus.color}"
      else
        "background-color: #{thing.phase.color}; color: #{thing.focus.color}"
      end
    end
  end

  def formatted(thing, td=false)
    key = thing.symbol
    symbol = cookies.has_key?('symbols') ?  nil : key
    word = cookies.has_key?('words') ?  nil : word(thing)
    if symbol && word
      phrase = [symbol.colon, word].to_phrase
    elsif symbol || word
      phrase = [symbol, word].to_phrase
    else
      phrase = thing.symbol
    end
    if css(thing, td).blank?
      Rails.logger.debug 'blank'
      phrase
    elsif td
      Rails.logger.debug 'td'
      '<td style="'.html_safe + css(thing, td) + '">'.html_safe + phrase + '</td>'.html_safe
    else
      Rails.logger.debug 'span'
      "<span style=#{css(thing)}>".html_safe + phrase + "</span>".html_safe
    end
  end

  def symbolic(thing)
    key = thing.symbol
    word = cookies[key] || thing.words.first
    [key.colon, word].to_phrase
  end

  def word(thing)
    if thing.is_a? Problem
      word = cookies[thing.symbol] ||
          [thing.cannot, word(thing.behavior)].to_phrase
    else
      cookies[thing.symbol] || thing.words.first
    end
  end

end
