class Thing < Concept

  SYMBOL = %w{F S T N}

  ALL = SYMBOL.collect {|symbol| self.new symbol}

  def +(concept)
    if concept.is_a? Action
      Behavior.all.find{|p| p.action == concept && p.thing == self}
    elsif concept.is_a? Imbalance
      Imbalance.all.find{|p| p.imbalance == concept && p.thing == self}
    elsif concept.is_a? State
      Solution.all.find{|p| p.state == concept && p.thing == self}
    end
  end

  def imbalances; Imbalance.all.select{|i| i.thing == self}; end

  def static; %w{people foods tools ideas}[index]; end

end
