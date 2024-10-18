module CookieHelper

  def compound(concept)
    if concept.is_a? Behavior
      action_words = word(concept.action)
      if action_words.match?('&') || (action_words.words.count == 1)
        [word(concept.thing), action_words].to_phrase
      else
        [action_words.first_words, word(concept.thing), action_words.last_words].to_phrase
      end
    else
      concept.parts.collect{|p| word(p)}.to_phrase
    end
  end

  def formatted(concept)
    case cookies['setting']
    when 'letters'
      return concept.symbol
    when 'words'
      return word(concept)
    else
      return [concept.symbol, word(concept).wrap].to_phrase
    end
  end

  def short_formatted(concept)
    case cookies['setting']
    when 'letters'
      return concept.symbol
    when 'words'
      return word(concept).words.first
    else
      return [concept.symbol, word(concept).words.first.wrap].to_phrase
    end
  end

  def word(concept)
    return cookies[concept.symbol] unless cookies[concept.symbol].blank?
    return concept.words.first unless concept.words.blank?
    if concept.is_a? Solution
      behavior_words = word(concept.behavior)
      amount = concept.extreme? ? behavior_words.more : behavior_words.less
    else
      compound(concept)
    end
  end


  def formatted_problem(solution)
    amount = solution.extreme? ? 'as little' : 'as much'
    "I already #{formatted(solution.behavior.opposite)} #{amount} as I can. I also try #{'not' unless solution.extreme?} to #{formatted(solution.behavior)}, but not always #{'little' unless solution.extreme?} enough."
  end

  def formatted_stress(solution)
    case cookies['setting']
    when 'letters'
      return solution.symbol
    when 'words'
      return stress_word(solution)
    else
      return [solution.symbol, stress_word(solution).wrap].to_phrase
    end
  end

  def stress_word(solution)
    [solution.thing.static, 'are', solution.extreme? ? 'very' : 'somewhat', solution.adjective].to_phrase
  end


end
