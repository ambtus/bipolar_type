class Focus < Concept

  SYMBOL = %w{F S T N}

  ALL = SYMBOL.collect {|symbol| self.new symbol}

  def +(state); Problem.all.find{|p| p.state == state && p.focus == self}; end

end
