module CookieHelper

  def compound(thing)
    if thing.is_a? Action
      behavior_words = word(thing.behavior)
      [behavior_words.first_words, word(thing.focus), behavior_words.last_word].to_phrase
    else
      thing.parts.collect{|p| word(p)}.to_phrase
    end
  end

  def formatted(thing)
    case cookies['setting']
    when 'symbols'
      return thing.symbol
    when 'words'
      return word(thing)
    else
      [thing.symbol, word(thing).wrap].to_phrase
    end
  end

  def word(thing)
    return cookies[thing.symbol] unless cookies[thing.symbol].blank?
    return thing.words.first unless thing.words.blank?
    if thing.is_a? Solution
      action_words = word(thing.action)
      amount = thing.extreme? ? action_words.more : action_words.less
    else
      compound(thing)
    end
  end

  def formatted_problem(solution)
    case cookies['setting']
    when 'symbols'
      return solution.symbol
    else
      return problem(solution)
    end
  end

  def problem(solution)
    action_words = word(solution.action.opposite)
    amount = solution.extreme? ? action_words.as_few : action_words.as_many
    more_or_less = solution.extreme? ? action_words.less : action_words.more
    "I already #{amount} as I can; I cannot #{more_or_less}."
  end

end
