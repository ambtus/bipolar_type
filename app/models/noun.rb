class Noun < Concept

  ########
  SYMBOLS = %w{E S}
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  SYMBOLS.each {|s| define_singleton_method(s) {ALL[SYMBOLS.index(s)]}}
  ########

  def phases; Phase.all.select{|p| p.noun == self}; end
  def +(verb); phases.find{|p| p.verb == verb}; end

  def word; %w{energy strength}[index]; end
  def nature; %w{weak strong}[index]; end
  def episode; %w{Spring Fall}[index]; end

end
