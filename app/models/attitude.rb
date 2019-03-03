class Attitude < Concept

  SYMBOLS = %w{IP EP EJ IJ}

  ########
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  PATHS.each do |path|
    define_singleton_method(path) {ALL[PATHS.index(path)]}
  end
  ########

  def self.answer_order; ALL.values_at(0,3,1,2); end

  SYMBOLS.each do |symbol|
    define_singleton_method(symbol.downcase) {ALL[SYMBOLS.index(symbol)]}
  end

  def subtypes; Subtype.all.select{|s| s.attitude == self}; end
  def +(realm); subtypes.find{|s| s.realm == realm}; end

  def adjective; %w{thin fat strong weak}[index]; end
  alias problem :adjective

  def input?; %w{thin fat}.include?(adjective); end
  def pain?; %w{thin weak}.include?(adjective); end
  def surplus?; %w{fat weak}.include?(adjective); end

  def first_amount; pain? ? "much" : "little"; end
  def stimulus; input? ? "input" : "output"; end
  def cause; "too #{first_amount} #{stimulus} pain"; end

  def second_amount; pain? ? "little" : "much"; end
  def behavior; input? ? "input" : "output"; end
  def effect; "too #{second_amount} #{behavior}"; end

  def result; surplus? ? "energy surplus" : "energy deficit"; end

  def opposite_stimulus; input? ? "output" : "input"; end

  def opposite; others.find{|x| x.symbol.first != self.symbol.first && x.symbol.second != self.symbol.second}; end

  def targets; input? ? "resources" : "goals"; end

  def solution; "focus on basic #{targets}"; end

end
