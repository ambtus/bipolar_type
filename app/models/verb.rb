class Verb < Concept
  # Jungian Attitude

  ########
  SYMBOLS = %w{U G}
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  SYMBOLS.each {|s| define_singleton_method(s) {ALL[SYMBOLS.index(s)]}}
  ########

  def generic_behaviors; GenericBehavior.all.select{|gb| gb.verb == self}; end
  def +(noun); generic_behaviors.find{|gb| gb.noun == noun}; end

  def word; %w{use get}[index]; end

  def problem; [GenericProblem.M, GenericProblem.D][index]; end

  def mbti; %w{I E}[index]; end

end
