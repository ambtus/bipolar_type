class Nature < Concept

  ########
  SYMBOLS = %w{W P}
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  SYMBOLS.each {|s| define_singleton_method(s) {ALL[SYMBOLS.index(s)]}}
  ########

  def problems; Problem.all.select{|s| s.nature == self}; end
  def +(nature); problems.find{|s| s.nature == nature}; end

  def subtypes; Subtype.all.select{|s| s.nurture == self}; end

  def attitude; %w{worthwhile painful}[index]; end

  def more_or_less; %w{more less}[index]; end

end
