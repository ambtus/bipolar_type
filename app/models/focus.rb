class Focus < Concept

  SYMBOL = %w{F S T N}

  ALL = SYMBOL.collect {|symbol| self.new symbol}

  def +(phase); Problem.all.find{|p| p.phase == phase && p.focus == self}; end

end
