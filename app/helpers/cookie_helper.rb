module CookieHelper

  def word(key)
    return cookies[key] unless cookies[key].blank?
    return Rails.application.config_for(:words)[key] unless Rails.application.config_for(:words)[key].blank?
    return 'cannot find word for #{key}'
  end

  def format(symbol, words)
    case cookies['setting']
    when 'symbols'
      return symbol
    when 'words'
      return words
    else
      return [symbol, words.wrap].to_phrase
    end
  end

  def tendency(subtype)
    format subtype.symbol, [word(subtype.thing.symbol), word(subtype.tendency.problem_key)].to_phrase
  end

  def format_from_key(key)
    format key, word(key)
  end

  def problem(tendency)
    format_from_key tendency.problem_key
  end

  def solution(subtype)
    format_from_key subtype.solution_key
  end

  def interference(subtype)
    format_from_key subtype.opposite.solution_key
  end

  def okay(subtype)
    format_from_key subtype.opposite.problem_key
  end

end
