class Action < Concept

  SYMBOL = %w{P J}

  ALL = SYMBOL.collect {|symbol| self.new symbol}

end
