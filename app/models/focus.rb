class Focus < Concept

  SYMBOL = %w{F S T N}

  ALL = SYMBOL.collect {|symbol| self.new symbol}

  def +(thing)
    if thing.is_a? Action
      Behavior.all.find{|p| p.action == thing && p.focus == self}
    elsif thing.is_a? State
      Problem.all.find{|p| p.state == thing && p.focus == self}
    end
  end

  def static; %w{people places things ideas}[index]; end

end
