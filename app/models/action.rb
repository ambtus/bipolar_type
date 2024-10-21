class Action < Concept

  SYMBOL = %w{P J}

  ALL = SYMBOL.collect {|symbol| self.new symbol}

  def +(thing); Behavior.all.find{|p| p.thing == thing && p.action == self}; end

end
