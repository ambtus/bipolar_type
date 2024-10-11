class Mood < Concept

  SYMBOL = %w{I E}

  ALL = SYMBOL.collect {|symbol| self.new symbol}

  def +(action); State.all.find{|p| p.action == action && p.mood == self}; end
end
