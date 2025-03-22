class Aspect < Concept

  SYMBOL = %w{P J}

  ALL = SYMBOL.collect {|symbol| self.new symbol}

  def +(focus); Behavior.all.find{|p| p.focus == focus && p.aspect == self}; end

  def static; %w{energy strength}[index]; end


end
