class Action < Concept

  def initialize(string); @symbol = string; end
  attr_reader :symbol

  ########
  SYMBOLS = %w{A B}
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  SYMBOLS.each_with_index{|s, i| define_singleton_method(s) {ALL[i]}}
  ########

  def problems; Problem.select{|x| x.action == self}; end
  def +(role); problems.find{|x| x.role == role}; end

end
