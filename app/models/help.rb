class Help < Concept

  SYMBOL = %w{C A R T}

  ALL = SYMBOL.collect {|symbol| self.new symbol}

  def verb; %w{change accept refuse tolerate}[index]; end

  def key; %w{↑ ↓ ¬↓ ¬↑}[index]; end

  def state; %w{Up Down NotDown NotUp}[index]; end

  def tendency_key; %w{ IJ EP IP EJ}[index]; end

end
