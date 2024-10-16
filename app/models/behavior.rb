class Behavior < Concept

  SYMBOL = %w{P J}

  ALL = SYMBOL.collect {|symbol| self.new symbol}

  def +(focus); Action.all.find{|p| p.focus == focus && p.behavior == self}; end

end
