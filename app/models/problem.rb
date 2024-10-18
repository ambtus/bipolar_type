class Problem < Concept

  SYMBOL = %w{I E}

  ALL = SYMBOL.collect {|symbol| self.new symbol}

  def +(concept)
    if concept.is_a?(Thing)
      Imbalance.all.find{|p| p.thing == concept && p.problem == self}
    elsif concept.is_a?(Action)
      State.all.find{|p| p.action == concept && p.problem == self}
    elsif concept.is_a?(Behavior)
      Solution.all.find{|p| p.behavior == concept && p.problem == self}
    end
  end

  def drugs; %w{sedatives stimulants}[index]; end

  def adjective; %w{stressful boring}[index]; end
  def static; ['things are', adjective].to_phrase; end

end
