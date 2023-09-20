class Verb < Concept

  ########
  SYMBOLS = %w{U G}
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  SYMBOLS.each {|s| define_singleton_method(s) {ALL[SYMBOLS.index(s)]}}
  ########

  def generic_behaviors; GenericBehavior.all.select{|gb| gb.verb == self}; end
  def generic_solutions; GenericSolution.all.select{|gs| gs.verb == self}; end
  def +(thing)
     generic_behaviors.find{|gb| gb.noun == thing} ||
     generic_solutions.find{|gs| gs.determiner == thing}
  end

  def focus; symbol == "U" ? Noun.S : Noun.E; end

  def word; %w{use get}[index]; end

end
