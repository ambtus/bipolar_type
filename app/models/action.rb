class Action < Concept

  SYMBOL = %w{P J}

  ALL = SYMBOL.collect {|symbol| self.new symbol}

  def +(focus); Behavior.all.find{|p| p.focus == focus && p.action == self}; end

end
