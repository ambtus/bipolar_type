class Focus < Concept

  SYMBOL = %w{F S T N}

  ALL = SYMBOL.collect {|symbol| self.new symbol}

  def +(thing)
    Behavior.all.find{|p| p.state == thing && p.focus == self}
  end

  def static; %w{people places things ideas}[index]; end

end
