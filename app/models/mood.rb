class Mood < Concept

  SYMBOL = %w{ I E }

  ALL = SYMBOL.collect {|symbol| self.new symbol}

  def +(thing)
    if thing.is_a?(Focus)
      Balance.all.find{|p| p.focus == thing && p.mood == self}
    elsif thing.is_a?(Aspect)
      State.all.find{|p| p.aspect == thing && p.mood == self}
    end
  end

  def static; %w{  sedatives stimulants }[index]; end
  def verb; %w{ use get}[index]; end

end
