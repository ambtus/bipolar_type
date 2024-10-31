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
    when 'words'
      triplet.second
    when 'things'
      triplet.third
    else
      [triplet.first.colon, triplet.second].to_phrase
    end
  end

  def triplet(thing)
    concept = thing.is_a?(Concept) ? thing : parse(thing)
    Rails.logger.debug "triplet for #{concept.inspect}"
    result = [concept.symbol, word(concept), generic_words(concept)]
    Rails.logger.debug "   is #{result}"
    result
  end

  def parse(symbol)
    key = symbol.to_s
    case key.length
    when 3
      Subtype.find_by(key)
    when 2
      Tendency.find_by(key) || Behavior.find_by(key)
    when 1
      Thing.find_by(key) || Help.find_by(key)
    end
  end


  def word(concept)
    if concept.is_a?(String)
      word(parse(concept))
    elsif concept.is_a?(Subtype)
      [word(concept.thing), word(concept.tendency)].to_phrase
    elsif concept.is_a?(Behavior)
      if concept.active?
        preference(concept.symbol)
      else
        'not ' + word(concept.opposite)
      end
    else
      preference(concept.symbol) || "cannot find word for #{concept.inspect}"
    end
  end

  def generic_words(concept)
    if concept.is_a?(Help)
      word(concept)
    elsif concept.is_a?(Behavior)
      [generic_words(concept.help), concept.thing.generic_words].to_phrase
    elsif concept.is_a?(Subtype)
      [generic_words(concept.help), 'too many', concept.thing.generic_words].to_phrase
    else
      concept.generic_words
    end
  end

  def preference(key)
    cookies[key] ||
    Rails.application.config_for(:words)[key] ||
    "don’t have preference for #{key}"
  end

  def role(subtype)
    if subtype.more?
      display(subtype.role) + ' when other people are ' + display(transform(subtype.solution, :ing))
    else
      'not ' + display(subtype.herring) + ' when other people are not ' + display(transform(subtype.problem, :ing))
    end
  end
end
