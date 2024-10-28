class Thing < Concept

  SYMBOL = %w{F S T N}

  ALL = SYMBOL.collect {|symbol| self.new symbol}

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

end
