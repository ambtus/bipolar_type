class Help < Concept

  SYMBOL = %w{C A R E}

  ALL = SYMBOL.collect {|symbol| self.new symbol}

  def verb; %w{change accept refuse endure}[index]; end

  def key; %w{↑ ↓ ¬↓ ¬↑}[index]; end

  def state; %w{Up Down NotDown NotUp}[index]; end

  def tendency_key; %w{ IJ EP IP EJ}[index]; end

  def opposite_index; [3, 2, 1, 0][index]; end
  def opposite; ALL[opposite_index]; end

end
