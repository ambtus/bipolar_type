class Realm < Concept

  SYMBOLS = %w{F S T N}

  ########
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  PATHS.each do |path|
    define_singleton_method(path) {ALL[PATHS.index(path)]}
  end
  ########

  SYMBOLS.each do |symbol|
    define_singleton_method(symbol.downcase) {ALL[SYMBOLS.index(symbol)]}
  end

  def subtypes; Subtype.all.select{|s| s.realm == self}; end
  def +(attitude); subtypes.find{|s| s.attitude == attitude}; end

  def rights; ALL.select{|x| x.index > self.index}; end


  def noun; %w{person place thing concept}[index]; end
  def nouns; noun.pluralize; end
  def a_noun; [noun.an, noun].join(" "); end

  def adjective; %w{spiritual physical material mental}[index]; end
  def adverb; adjective + "ly"; end

  def energy; %w{affect calories money data}[index]; end
  def energetic; %w{affective caloric financial informational}[index]; end
  def an_energetic; [energetic.an, energetic].join(" "); end

  def sense; %w{hear smell touch see}[index]; end
  def emotion; %w{misery disgust anger fear}[index]; end
  def emotional; %w{miserable disgusted angry afraid}[index]; end
  def less_emotional; %w{gloomy nauseated irritable anxious}[index]; end

  def process; %w{listen eat work look}[index]; end
  def preposition; %w{to in with at}[index]; end

  def act; %w{talk walk buy think}[index]; end

  def improve; %w{advise cultivate build postulate}[index]; end


  def reserves; %w{faith fat savings knowledge}[index]; end
  def empty; %w{hopeless hungry overdrawn unsure}[index]; end

end
