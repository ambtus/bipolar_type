class GenericProblem < Concept

  ########
  SYMBOLS = %w{D S}
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  SYMBOLS.each {|s| define_singleton_method(s) {ALL[SYMBOLS.index(s)]}}
  ########

  def imbalance; %w{deficit surplus}[index]; end
  def state; %w{manic depressed}[index]; end

  def words; [state, imbalance].to_phrase; end

  def solutions; GenericSolution.all.select{|s| s.problem == self}; end

end
