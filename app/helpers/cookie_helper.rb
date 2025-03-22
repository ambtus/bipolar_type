module CookieHelper

  def symbolic(thing)
    [thing.symbol.colon, word(thing)].to_phrase
  end

  def formatted(thing)
    case cookies['setting']
    when 'symbols'
      return thing.symbol
    when 'words'
      return word(thing)
    else
      symbolic(thing)
    end
  end

  def word(thing)
    return cookies[thing.symbol] unless cookies[thing.symbol].blank?
    return thing.words.first unless thing.words.blank?
    thing.parts.collect{|p| word(p)}.to_phrase
  end

end
