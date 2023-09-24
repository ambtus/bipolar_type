class GenericProblem < Concept

  ########
  SYMBOLS = %w{M C D R}
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  SYMBOLS.each {|s| define_singleton_method(s) {ALL[SYMBOLS.index(s)]}}
  ########

  def problems; Problem.all.select{|b| b.generic_problem == self}; end

  def word; %w{mania exhaustion depression weakness}[index]; end

end
