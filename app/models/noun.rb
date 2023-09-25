class Noun < Concept

  ########
  SYMBOLS = %w{E S}
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  SYMBOLS.each {|s| define_singleton_method(s) {ALL[SYMBOLS.index(s)]}}
  ########

  def word; %w{energy strength}[index]; end

  def problem; [GenericProblem.W, GenericProblem.E][index]; end

  def mbti; %w{P J}[index]; end

end
