class Noun < Concept

  ########
  SYMBOLS = %w{E S}
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  SYMBOLS.each {|s| define_singleton_method(s) {ALL[SYMBOLS.index(s)]}}
  ########

  def word; %w{energy strength}[index]; end
  def strong?; index == 1; end
  def problem; %w{weak too\ strong}[index]; end

  def assets; %w{reserves powers}[index]; end

  def mbti; %w{P J}[index]; end

end
