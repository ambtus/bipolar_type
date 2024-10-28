module ApplicationHelper

  def transform(behavior, method, *args)
    Rails.logger.debug "transform #{behavior.inspect} by #{method.inspect} with #{args.inspect}"
    triplet(behavior).each_with_index.map{|t,i| i==1 ? t.send(method, *args).clean : t }
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
    result = [symbol(concept), word(concept), concept.generic_words]
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

  def symbol(concept)
    concept.symbol.dup
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

  def preference(key)
    cookies[key] ||
    Rails.application.config_for(:words)[key] ||
    "don’t have preference for #{key}"
  end

  def role(subtype)
    if subtype.more?
      display(subtype.role) + ' when other people want to ' + display(subtype.solution)
    else
      'not ' + display(subtype.herring) + ' when other people don’t want to ' + display(subtype.problem)
    end
  end
end
