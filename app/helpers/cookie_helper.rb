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
      if concepts[:tendency].blank?
        concepts[:help] = Help.find_by(key.to_s.first)
        concepts[:thing] = Thing.find_by(key.to_s.second)
      end
    end
    return concepts
  end

  def found(key)
    cookie = cookies[key] unless cookies[key].blank?
    default = Rails.application.config_for(:words)[key] unless Rails.application.config_for(:words)[key].blank?
    cookie || default
  end

  def word(key)
    concepts = parse(key)
    Rails.logger.debug "word concepts: #{concepts}"
    if concepts[:subtype]
      [word(concepts[:subtype].thing.symbol), word(concepts[:subtype].tendency.symbol)].to_phrase
    elsif concepts[:help] && concepts[:thing]
      if found(key)
        found(key)
      else
        'not ' + found(concepts[:help].opposite.symbol + concepts[:thing].symbol)
      end
    elsif concepts[:help]
      concepts[:help].verb
    else
      found(key) || "cannot find word for #{key.inspect}"
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
      verb = concepts[:help].verb.capitalize
      symbol = nil
    elsif concepts[:thing]
      verb = nil
      symbol = concepts[:thing].symbol
    elsif concepts[:tendency]
      verb = concepts[:tendency].verb
      symbol = 'too many'
    else
      return "cannot find word for #{key.inspect}"
    end
    [verb, symbol, 'things'].to_phrase
  end

  def format_from_key(key)
    case cookies['setting']
    when 'symbols'
      key
    when 'words'
      word(key)
    when 'things'
      generic_words(key)
    else
      [key.colon, word(key)].to_phrase
    end
  end

  %w{problem solution role herring}.each do |string|
    define_method('format_' + string) do |subtype, clean=true|
      words = format_from_key(subtype.send(string + '_key'))
      clean ? words.clean : words
    end
    define_method('do_format_' + string) do |subtype|
      words = format_from_key(subtype.send(string + '_key'))
      case cookies['setting']
      when 'words', 'things'
        "do #{words}".clean
      else
        [words.first_words, "do #{words.last_words}".clean].to_phrase
      end
    end
  end

  def role(subtype)
    if subtype.more?
      format_role(subtype) + ' when other people want to ' + format_solution(subtype)
    else
      'not ' + format_herring(subtype) + ' when other people don’t want to ' + found(subtype.help.symbol + subtype.thing.symbol)
    end.clean
  end

end
