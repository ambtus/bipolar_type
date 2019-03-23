class Attitude < Concept

  SYMBOLS = %w{i j p e}

  ########
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  PATHS.each do |path|
    define_singleton_method(path) {ALL[PATHS.index(path)]}
  end
  ########

  def self.answer_order; ALL; end

  SYMBOLS.each do |symbol|
    define_singleton_method(symbol.downcase) {ALL[SYMBOLS.index(symbol)]}
  end

  def subtypes; Subtype.all.select{|s| s.attitude == self}; end
  def +(realm); subtypes.find{|s| s.realm == realm}; end


  def adjective; %w{picky lazy greedy hyperactive}[index]; end
  def problem; %w{manic depressed fat skinny}[index]; end

  def surplus?; %w{greedy lazy}.include?(adjective); end
  def input?; %w{greedy picky}.include?(adjective); end
  def pain?; %w{lazy picky}.include?(adjective); end

  def amount; pain? ? "few" : "many"; end
  def hit; input? ? "process" : "achieve"; end
  def targets; input? ? "resources" : "goals"; end
  def nature; "there are too #{amount} #{targets} I want to #{hit}"; end

  def bad; input? ? "manic" : "depressed"; end

  def imbalance; surplus? ? "surplus" : "deficit"; end
  def imbalancing; surplus? ? "gaining unwanted" : "losing critical"; end

  def drug; surplus? ? "stimulant" : "sedative"; end
  def drug_reaction; pain? ? "tolerate having to" : "avoid wanting to"; end

  def same_result; others.find{|x| x.surplus? == self.surplus? && x != self}; end
  def same_focus; others.find{|x| x.input? == self.input? && x != self}; end
  def opposite; (others - [self, same_result, same_focus]).first; end

  def same_amount; pain? ? "fewer" : "more"; end
  def cure; "be #{opposite.adjective}"; end
  def red_herring; "#{opposite.hit} #{same_amount} #{opposite.targets}"; end

  def advice; "be #{same_focus.adjective}"; end
  def better; pain? ? "appealing" : "necessary"; end
  def useful_clue; "#{hit} #{better} #{targets}"; end

  def good; pain? ? "healthy" : "important"; end

  def pre_hit; input? ? "harvest" : "act"; end
  def pre_hit_amount; pain? ? "less" : "more"; end

end
