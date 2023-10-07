class Verb < Concept
  # Jungian Attitude

  ########
  SYMBOLS = %w{U G}
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  SYMBOLS.each {|s| define_singleton_method(s) {ALL[SYMBOLS.index(s)]}}
  ########

  def phases; Phase.all.select{|p| p.verb == self}; end
  def +(noun); phases.find{|p| p.noun == noun}; end

  def word; %w{use get}[index]; end

  def nature; %w{empty full}[index]; end

  def episode; %w{Mania Depression}[index]; end
  def sick; %w{manic depressed}[index]; end
  def manic?; index == 0; end

  def focus; %w{output intake}[index]; end

  def stop_drugs; %w{sedatives stimulants}[index]; end

  def mbti; %w{I E}[index]; end

end
