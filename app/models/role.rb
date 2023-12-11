class Role < Concept

  def initialize(string); @symbol = string; end
  attr_reader :symbol

  ########
  SYMBOLS = %w{P J}
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  SYMBOLS.each_with_index{|s, i| define_singleton_method(s) {ALL[i]}}
  ########

  def problems; Problem.select{|x| x.role == self}; end
  def +(action); problems.find{|x| x.action == action}; end

end
