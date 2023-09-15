class Cycle < Concept

  ########
  SYMBOLS = %w{G U}
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  SYMBOLS.each {|s| define_singleton_method(s) {ALL[SYMBOLS.index(s)]}}
  ########

  def cycle_behaviors; CycleBehavior.all.select{|s| s.cycle == self}; end
  def +(cycle_type); problems.find{|s| s.cycle_type == cycle_type}; end

  def behaviors; Behavior.all.select{|s| s.cycle == self}; end

  def verb; %w{get use}[index]; end

end
