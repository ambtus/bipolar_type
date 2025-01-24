module ApplicationHelper

  def transform(behavior, method, *args)
    Rails.logger.debug "transform #{behavior.inspect} by #{method.inspect} with #{args.inspect}"
    triplet(behavior).each_with_index.map{|t,i| i==0 ? t : t.dup.send(method, *args).clean }
  end

  def display(thing)
    triplet = thing.is_a?(Array) ? thing : triplet(thing)
    case cookies['setting']
    when 'symbols'
      triplet.first
    when 'both'
      [triplet.first, triplet.second.wrap].to_phrase
    when 'things'
      triplet.third
    else
      triplet.second
    end
  end

  def triplet(thing)
    concept = thing.is_a?(Concept) ? thing : parse(thing)
    Rails.logger.debug "triplet for #{concept.inspect}"
    result = [concept.symbol, word(concept), generic_words(concept)]
    Rails.logger.debug "   is #{result}"
    result
  end

  def word(concept)
    if concept.is_a?(String)
      word(parse(concept))
    elsif concept.is_a?(Subtype)
      [word(concept.realm).ly, word(concept.attitude)].to_phrase
    else
      preference(concept.symbol) || "cannot find word for #{concept.inspect}"
    end
  end

  def preference(key)
    cookies[key] ||
    Rails.application.config_for(:words)[key] ||
    "don’t have preference for #{key}"
  end

  def generic_words(concept)
    concept.generic_words
  end

  def parse(symbol)
    key = symbol.to_s
    case key.length
    when 2
      Subtype.find_by(key)
    when 1
      Realm.find_by(key) || Attitude.find_by(key)
    end
  end

end
