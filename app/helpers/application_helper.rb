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
      [triplet.first.colon, triplet.second].to_phrase
    else
      triplet.second
    end
  end

  def triplet(thing)
    Rails.logger.debug "triplet for #{thing.inspect}"
    result = [thing.symbol, preference(thing)]
    Rails.logger.debug "   is #{result}"
    result
  end

  def preference(thing)
    if thing.is_a?(Type)
      thing.subtypes.collect{|s| preference(s)}.join('•')
    elsif thing.is_a?(Subtype) && !thing.dominant?
      thing.parts.collect{|p| preference(p)}.to_phrase
    else
      cookies[thing.symbol] ||
      Rails.application.config_for(:words)[thing.symbol] ||
      "don’t have preference for #{thing}"
    end
  end

end
