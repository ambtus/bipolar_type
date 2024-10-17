module CookieHelper

  def compound(thing)
    if thing.is_a? Behavior
      action_words = word(thing.action)
      if action_words.match?('&') || (action_words.words.count == 1)
        [word(thing.focus), action_words].to_phrase
      else
        [action_words.first_words, word(thing.focus), action_words.last_word].to_phrase
      end
    else
      thing.parts.collect{|p| word(p)}.to_phrase
    end
  end

  def formatted(thing)
    case cookies['setting']
    when 'letters'
      return thing.symbol
    when 'words'
      return word(thing)
    else
      return [thing.symbol, word(thing).wrap].to_phrase
    end
  end

  def short_formatted(thing)
    case cookies['setting']
    when 'letters'
      return thing.symbol
    when 'words'
      return word(thing).first_word
    else
      return [thing.symbol, word(thing).first_word.wrap].to_phrase
    end
  end

  def word(thing)
    return cookies[thing.symbol] unless cookies[thing.symbol].blank?
    return thing.words.first unless thing.words.blank?
    if thing.is_a? Solution
      behavior_words = word(thing.behavior)
      amount = thing.extreme? ? behavior_words.more : behavior_words.less
    else
      compound(thing)
    end
  end


  def formatted_problem(solution)
    amount = solution.extreme? ? 'as little' : 'as much'
    "I already #{formatted(solution.behavior.opposite)} #{amount} as I can. I also try #{'not' unless solution.extreme?} to #{formatted(solution.behavior)}, but not always #{'little' unless solution.extreme?} enough."
  end

end
