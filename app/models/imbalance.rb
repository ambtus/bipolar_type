class Imbalance < Concept

  SYMBOL = %w{I E}

  ALL = SYMBOL.collect {|symbol| self.new symbol}

  def +(thing)
    if thing.is_a?(Focus)
      Problem.all.find{|p| p.focus == thing && p.imbalance == self}
    elsif thing.is_a?(Action)
      State.all.find{|p| p.action == thing && p.imbalance == self}
    elsif thing.is_a?(Behavior)
      Solution.all.find{|p| p.behavior == thing && p.imbalance == self}
    end
  end

  def drugs; %w{sedatives stimulants}[index]; end

end
