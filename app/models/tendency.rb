class Tendency < Concept

  SYMBOL = %w{IP IJ EP EJ}

  ALL = SYMBOL.collect {|symbol| self.new symbol}

  def +(concept)
    Subtype.all.find{|p| p.tendency == self && p.thing == thing}
  end

  def problem_key; %w{¬↓ ↑ ↓ ¬↑}[index]; end
  def solution_key; %w{↓ ¬↑ ¬↓ ↑}[index]; end

  class << self
    def ep; ALL.find{|p| p.symbol == 'EP'}; end
    def ip; ALL.find{|p| p.symbol == 'IP'}; end
    def ej; ALL.find{|p| p.symbol == 'EJ'}; end
    def ij; ALL.find{|p| p.symbol == 'IJ'}; end
  end

  def flip; ALL.values_at(2,3,0,1)[index]; end
  def flop; ALL.values_at(3,2,1,0)[index]; end
  def opposite; flip.flop; end

  def extreme?; [0,3].include?(index); end

  def normal; %w{midday evening afternoon morning}[index]; end
  def alternate; opposite.normal; end

  def season; %w{winter summer spring fall}[index]; end
  def worst_season; opposite.season; end

  def verb; %w{accept tolerate reject change}[index]; end

end
