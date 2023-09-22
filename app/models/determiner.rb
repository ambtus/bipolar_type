class Determiner < Concept

  ########
  SYMBOLS = %w{L M}
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  SYMBOLS.each {|s| define_singleton_method(s) {ALL[SYMBOLS.index(s)]}}
  ########

  def word; %w{less more}[index]; end

end
