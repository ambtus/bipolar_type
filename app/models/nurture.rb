class Nurture < Concept

  ########
  SYMBOLS = %w{D S}
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  SYMBOLS.each {|s| define_singleton_method(s) {ALL[SYMBOLS.index(s)]}}
  ########

  def problems; Problem.all.select{|s| s.nature == self}; end
  def +(nurture); problems.find{|s| s.nurture == nurture}; end

  def subtypes; Subtype.all.select{|s| s.nurture == self}; end

  def problem; %w{deficit surplus}[index]; end
end
