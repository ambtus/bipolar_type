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
    if thing.is_a? Problem
      word = cookies[thing.symbol] ||
          [word(thing.behavior), thing.extreme? ? 'too little' : 'too much'].to_phrase
    else
      cookies[thing.symbol] || thing.words.first
    end
  end

end
