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
  def problem; index < 2 ? "deficit" : "surplus"; end
  def state; index < 2 ? "manic" : "depressed"; end
  def ability; determiner.ability; end

  def solutions; Solution.all.select{|s| s.generic_solution == self}; end

  def words; [verb, determiner, focus].map(&:word).to_phrase; end

  def problem_behavior; %w{process_energy get_energy achieve_strength use_strength}[index]; end
end
