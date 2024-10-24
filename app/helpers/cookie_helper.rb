module CookieHelper

  def word(key)
    return cookies[key] unless cookies[key].blank?
    return Rails.application.config_for(:words)[key] unless Rails.application.config_for(:words)[key].blank?
    return "cannot find word for #{key}"
  end

  def generic_words(key)
    thing = Thing.find_by(key.to_s.first)
    help = Help.find_by(key.to_s.second)
    if help
      [help.verb, thing.symbol, 'things'].to_phrase
    elsif thing
        key.to_s + ' things'
    else
      ['tendency to',
      Help.all.find{|h| h.tendency_key == key.to_s}.verb,
      'things'].to_phrase
    end
  end


  def tendency(subtype)
    case cookies['setting']
    when 'symbols'
      subtype.symbol
    when 'generics'
      ['tendency to',
      subtype.tendency.verb, subtype.thing.symbol,
      'things'].to_phrase
    else
      [word(subtype.thing.symbol), word(subtype.tendency.symbol)].to_phrase

    end
  end

  def format_from_key(key)
    case cookies['setting']
    when 'symbols'
      thing = Thing.find_by(key.to_s.first)
      help = Help.find_by(key.to_s.second)
      if help
        thing.symbol + help.key
      else
        key
      end
    when 'generics'
      generic_words(key)
    else
      word(key)
    end
  end

  def format_solution(subtype)
    format_from_key subtype.solution_key
  end

  def format_problem(subtype)
    format_from_key subtype.problem_key
  end
end
