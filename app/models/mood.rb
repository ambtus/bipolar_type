class Mood < Concept

  SYMBOL = %w{I E}

  ALL = SYMBOL.collect {|symbol| self.new symbol}

  def prep; %w{to after}[index]; end

end
