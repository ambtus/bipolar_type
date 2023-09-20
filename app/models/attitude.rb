class Attitude < Concept

  ########
  SYMBOLS = %w{D U}
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  SYMBOLS.each {|s| define_singleton_method(s) {ALL[SYMBOLS.index(s)]}}
  ########

  def word; %w{dysphoric unhealthy}[index]; end

end
