class Tendency < Concept

  SYMBOL = %w{IP IJ EP EJ}

  ALL = SYMBOL.collect {|symbol| self.new symbol}

  def +(concept)
    Subtype.all.find{|p| p.tendency == self && p.thing == thing}
  end

  def problem_key; %w{R C A E}[index]; end
  def solution_key; %w{A E R C}[index]; end

  def opposite; ALL.values_at(1,0,3,2)[index]; end

  def extreme?; [0,3].include?(index); end

  def help; Help.all.find{|h| h.tendency_key == symbol}; end
  def verb; help.verb; end

end
