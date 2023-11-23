class Verb < Concept

  ########
  SYMBOLS = %w{U G}
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  SYMBOLS.each {|s| define_singleton_method(s) {ALL[SYMBOLS.index(s)]}}
  ########

  def phases; Phase.all.select{|p| p.verb == self}; end
  def +(noun); phases.find{|p| p.noun == noun}; end

  def word; %w{use get}[index]; end
  def cycle; %w{up down}[index]; end
  def nature; %w{thin fat}[index]; end
  def episode; %w{Mania Depression}[index]; end
  def sick; %w{manic depressed}[index]; end

end
