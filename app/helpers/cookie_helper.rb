module CookieHelper

  def word(key, recursive=true)
    return cookies[key] unless cookies[key].blank?
    return words(key).first unless words(key).blank?
    return derived(key) if recursive
  end

  def words(key)
    Rails.application.config_for(:words)[key]
  end

  def derived(key)
    return word(key.to_s.first(2)).ly if key.ends_with?('ly')
    return 'not ' + word(key.to_s.chop, false) if key.ends_with?('d')
  end

  def problem_words(subtype)
    [word(subtype.thing.symbol + 'ly'), subtype.tendency.adjective].to_phrase
  end

  def problem(subtype)
    formatted subtype.symbol, problem_words(subtype)
  end

  def solution_words(subtype)
    word(subtype.key)
  end

  def solution(subtype)
    formatted subtype.key, solution_words(subtype)
  end

  def long_key(key)
    key.to_s.gsub('i', 'in').gsub('o', 'out').gsub('d', '¬')
  end

  def formatted(key, words)
    case cookies['setting']
    when 'letters'
      return long_key(key)
    when 'words'
      return words
    else
      return [long_key(key), words.wrap].to_phrase
    end
  end

end
