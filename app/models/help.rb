class Help < Concept

  SYMBOL = %w{C A R E}

  ALL = SYMBOL.collect {|symbol| self.new symbol}

  def season; %w{spring summer fall winter}[index]; end
  def time; %w{morning midday afternoon evening}[index]; end
  def verb; %w{change accept refuse endure}[index]; end
  def phase; %w{waxing full waning new}[index]; end
  def day; %w{Monday Wednesday Friday Weekend}[index]; end

  def tendency_key; %w{IJ EP IP EJ}[index]; end
  def tendency; Tendency.all.find{|t| t.problem_key == symbol}; end

  def active?; index < 2; end

  def opposite_index; [3, 2, 1, 0][index]; end
  def opposite; ALL[opposite_index]; end

  def flop_index; [2, 3, 0, 1][index]; end
  def flop; ALL[flop_index]; end

  def flip_index; [1,0,3,2][index]; end
  def flip; ALL[flip_index]; end

  def before; ALL[index-1]; end
  def after; ALL[(index+1)%4]; end

  def cycle_name; [season, time].to_phrase.titleize; end
  def full_name; [season, phase, 'moon', day, time].to_phrase.titleize; end

  def long
    case symbol
    when 'C'
      'use strength to improve your environment'
    when 'A'
      'get energy to refuel your strength'
    when 'R'
      'stop getting energy when you are full'
    when 'E'
      'stop using strength when you are tired'
    end
  end

  

  def +(concept)
    Behavior.all.find{|b| b.thing == concept && b.help == self}
  end

end
