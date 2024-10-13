module CookieHelper

  def symbolic(thing)
    [thing.symbol, word(thing).wrap].to_phrase
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
    if thing.is_a? Problem
      [word(thing.behavior), thing.extreme? ? 'too little' : 'too much'].to_phrase
    else
      compound(thing)
    end
  end

  def compound(thing)
    thing.parts.collect{|p| word(p)}.to_phrase
  end

end
