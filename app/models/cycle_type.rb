class CycleType < Concept

  ########
  SYMBOLS = %w{S E}
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  SYMBOLS.each {|s| define_singleton_method(s) {ALL[SYMBOLS.index(s)]}}
  ########

  def problems; Problem.all.select{|s| s.nature == self}; end
  def +(nature); problems.find{|s| s.nature == nature}; end

  def behaviors; Behavior.all.select{|s| s.cycle == self}; end

  def noun; %w{strength energy}[index]; end

end
