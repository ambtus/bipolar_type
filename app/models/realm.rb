class Realm < Concept

  SYMBOLS = %w{P M A F}

  def initialize(string); @symbol = string; end


  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  def self.all; self::ALL; end
  def self.each(&block);self::ALL.each(&block); end
  SYMBOLS.each{|s| define_singleton_method(s) {ALL[SYMBOLS.index(s)]}}
  def inspect; @symbol; end
  def index; self.class::SYMBOLS.index @symbol; end

  def behaviors; Behavior.all.select{|s| s.realm == self}; end
  def solutions; Solution.all.select{|s| s.realm == self}; end
  def problems; Problem.all.select{|s| s.realm == self}; end
  def +(thing)
     behaviors.find{|b| b.generic_behavior == thing} ||
     solutions.find{|s| s.generic_solution == thing} ||
     problems.find{|p| p.generic_problem == thing}
  end

  def word; %w{physical mental affective financial}[index]; end

  def sense; %w{smell/taste sight hearing touch}[index]; end
  def neuro; %w{serotonin glutamate oxytocin dopamine}[index]; end
end
