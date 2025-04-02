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
    if thing.is_a?(Type)
      result = [thing.symbol, thing.subtypes.collect{|s| preference(s.symbol)}.join('•')]
    else
      result = [thing.symbol, preference(thing.symbol)]
    end
    Rails.logger.debug "   is #{result}"
    result
  end

  def preference(key)
    cookies[key] ||
    Rails.application.config_for(:words)[key] || "don’t have preference for #{key}"
  end

end
