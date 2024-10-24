module CookieHelper

  def parse(key)
    concepts = {}
    case key.length
    when 3
      concepts[:subtype] = Subtype.find_by(key.to_s)
    when 1
      concepts[:thing] = Thing.find_by(key.to_s)
      concepts[:help] = Help.find_by(key.to_s)
    when 2
      concepts[:tendency] = Tendency.find_by(key.to_s)
      concepts[:thing] = Thing.find_by(key.to_s.first)
      concepts[:help] = Help.find_by(key.to_s.second)
    end
    return concepts
  end

  def symbol(key)
    concepts = parse(key)
    Rails.logger.debug "symbol concepts: #{concepts}"
    if concepts[:help] && concepts[:thing]
      concepts[:thing].symbol + concepts[:help].key
    elsif concepts[:help]
      concepts[:help].key
    else
      key
    end
  end

  def word(key)
    return cookies[key] unless cookies[key].blank?
    return Rails.application.config_for(:words)[key] unless Rails.application.config_for(:words)[key].blank?
    concepts = parse(key)
    Rails.logger.debug "word concepts: #{concepts}"
    if concepts[:subtype]
      [word(concepts[:subtype].thing.symbol), word(concepts[:subtype].tendency.symbol)].to_phrase
    elsif concepts[:help] && concepts[:thing]
      'do not ' + word(concepts[:thing].symbol + concepts[:help].opposite.symbol)
    elsif concepts[:help]
      word concepts[:help].tendency_key
    else
      "cannot find word for #{key.inspect}"
    end
  end

  def generic_words(key)
    concepts = parse(key)
    Rails.logger.debug "generic concepts: #{concepts}"
    if concepts[:subtype]
      verb = concepts[:subtype].verb
      symbol = 'too many ' + concepts[:subtype].thing.symbol
    elsif concepts[:help] && concepts[:thing]
      verb = concepts[:help].verb
      symbol = concepts[:thing].symbol
    elsif concepts[:help]
      verb = nil
      symbol = concepts[:help].key
    elsif concepts[:thing]
      verb = nil
      symbol = concepts[:thing].symbol
    elsif concepts[:tendency]
      verb = concepts[:tendency].verb
    else
      return "cannot find word for #{key.inspect}"
    end
    [verb, symbol, 'things'].to_phrase
  end

  def format_from_key(key)
    case cookies['setting']
    when 'symbols'
      symbol(key)
    when 'words'
      word(key)
    when 'things'
      generic_words(key)
    else
      symbol = symbol(key)
      generic_words = generic_words(key)
      words = word(key)
      [words.colon, symbol].to_phrase
    end
  end

  def format_solution(subtype)
    format_from_key subtype.solution_key
  end

  def format_problem(subtype)
    format_from_key subtype.problem_key
  end

end
