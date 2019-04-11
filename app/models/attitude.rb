class Attitude < Concept

  SYMBOLS = %w{G P L H}

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


  def adjective; %w{greedy picky lazy hyperactive}[index]; end
  alias problem :adjective

  def input?; %w{greedy picky}.include?(adjective); end
  def averse?; %w{lazy picky}.include?(adjective); end
  def surplus?; %w{greedy lazy}.include?(adjective); end

  def behavior; input? ? "get energy" : "use energy"; end
  def focus; averse? ? "hit the target" : "just do it"; end
  def compulsion; input? ? "binge" : "splurge"; end

  def hit; input? ? "harvest" : "change"; end
  def target; input? ? "resource" : "location"; end
  def targets; target.s; end

  def result; surplus? ? "fat" : "skinny"; end

  def imbalance; surplus? ? "surplus" : "deficit"; end
  def rebalance; surplus? ? "lose excess" : "gain critical"; end
  def change; surplus? ? "gain" : "lose"; end
  def episode; "#{change.ing} energy"; end

  def drugs; surplus? ? "stimulants" : "sedatives"; end

  def same_target; others.find{|x| x.input? == self.input? && x != self}; end
  def same_aversion; others.find{|x| x.averse? == self.averse? && x != self}; end
  def same_imbalance; others.find{|x| x.surplus? == self.surplus? && x != self}; end

end
