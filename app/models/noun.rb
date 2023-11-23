class Noun < Concept

  ########
  SYMBOLS = %w{E S}
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  SYMBOLS.each {|s| define_singleton_method(s) {ALL[SYMBOLS.index(s)]}}
  ########

  def phases; Phase.all.select{|p| p.noun == self}; end
  def +(verb); phases.find{|p| p.verb == verb}; end

  def word; %w{energy strength}[index]; end
  def cycle; %w{early late}[index]; end
  def focus; %w{intake output}[index]; end
  def behave; %w{down up}[index]; end

end
