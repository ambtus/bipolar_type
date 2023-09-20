class State < Concept

  ########
  SYMBOLS = %w{M D}
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  SYMBOLS.each {|s| define_singleton_method(s) {ALL[SYMBOLS.index(s)]}}
  ########

  def word; %w{mania depression}[index]; end

end
