class Help < Concept

  SYMBOL = %w{C A R E}

  ALL = SYMBOL.collect {|symbol| self.new symbol}

  def season; %w{spring summer fall winter}[index]; end
  def time; %w{morning midday afternoon evening}[index]; end
  def verb; %w{change accept refuse endure}[index]; end

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
  def episode_name; [season, episode].to_phrase.titleize; end
  def both_name; [season, time, episode].to_phrase.titleize; end
  def things_name; [verb, 'things', key].to_phrase.titleize; end
  def name(setting=nil)
    case setting
    when 'words'
      verb.capitalize
    when 'symbols'
      symbol
    when 'things'
      [verb.capitalize, 'Things'].to_phrase
    else
      verb.capitalize
    end
  end

  def +(concept)
    Behavior.all.find{|b| b.thing == concept && b.help == self}
  end

end
