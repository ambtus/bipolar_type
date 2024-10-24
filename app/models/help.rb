class Help < Concept

  SYMBOL = %w{C A R E}

  ALL = SYMBOL.collect {|symbol| self.new symbol}

  def season; %w{spring summer fall winter}[index]; end
  def time; %w{morning midday afternoon evening}[index]; end
  def verb; %w{change accept refuse endure}[index]; end
  def key; %w{↑ ↓ ¬↓ ¬↑}[index]; end

  def episode; index.even? ? 'mania' : 'depression'; end
  def state; %w{Up Down NotDown NotUp}[index]; end

  def tendency_key; %w{IJ EP IP EJ}[index]; end
  def tendency; Tendency.all.find{|t| t.problem_key == symbol}; end

  def opposite_index; [3, 2, 1, 0][index]; end
  def opposite; ALL[opposite_index]; end

  def cycle_name; [season, time].to_phrase.titleize; end
  def episode_name; [season, episode].to_phrase.titleize; end
  def name; [verb, 'things', key].to_phrase.titleize; end

end
