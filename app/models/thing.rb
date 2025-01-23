class Thing < Concept

  SYMBOL = %w{F S N T}

  ALL = SYMBOL.collect {|symbol| self.new symbol}

  NAMES = %w{Emotional Physical Mental Financial}
  def energy; %w{affect calories data money}[index]; end
  def vehicle; %w{heart body mind purse}[index]; end

  def +(concept)
    if concept.is_a? Tendency
      Subtype.all.find{|p| p.tendency == concept && p.thing == self}
    elsif concept.is_a? Help
      result = Behavior.all.find{|p| p.help == concept && p.thing == self}
      Rails.logger.debug "found #{result.inspect} for #{self.inspect} and #{concept.class} #{concept.inspect}"
      return result
    else
      raise "don’t know how to add #{concept.class} to a thing"
    end
  end

  def subtypes; Subtype.all.select{|s| s.thing == self}; end

  def method_missing(meth, *args, **kwargs, &block)
    [meth.to_s.humanize, name.downcase.wrap].to_phrase
  end

end
