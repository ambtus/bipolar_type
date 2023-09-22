class GenericSolution < Concept

  def initialize(string)
    @symbol = string
    @verb = Verb.send(string.first)
    @determiner = Determiner.send(string.second)
  end
  attr_reader :symbol, :verb, :determiner

  ########
  SYMBOLS = %w{UL GM UM GL}
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  SYMBOLS.each {|s| define_singleton_method(s) {ALL[SYMBOLS.index(s)]}}
  ########

  def focus; verb.focus; end

  def problem; index < 2 ? GenericProblem.D : GenericProblem.S; end

  def solutions; Solution.all.select{|s| s.generic_solution == self}; end

  def words; [verb, determiner, focus].map(&:word).to_phrase; end

end
