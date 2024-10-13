class Mood < Concept

  SYMBOL = %w{I E}

  ALL = SYMBOL.collect {|symbol| self.new symbol}

  def +(focus); Balance.all.find{|p| p.focus == focus && p.mood == self}; end

end
