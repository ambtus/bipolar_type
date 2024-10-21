class Thing < Concept

  SYMBOL = %w{F S T N}

  ALL = SYMBOL.collect {|symbol| self.new symbol}

  def +(concept)
    Subtype.all.find{|p| p.tendency == concept && p.thing == self}
  end

end
