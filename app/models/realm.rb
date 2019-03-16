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

  def adjective; %w{spiritual physical material mental}[index]; end
  def adverb; %w{emotionally physically financially mentally}[index]; end

  def target; %w{person place thing idea}[index]; end
  def targets; target.s; end
  def thing; %w{one where thing thing}[index]; end
  def name; targets.capitalize; end

  def sense; %w{hear smell/taste touch see}[index]; end

  def energy; %w{affect glucose cash data}[index]; end
  def energetic; %w{affective caloric financial knowledge}[index]; end
  def an_energetic; [energetic.an, energetic].join(" "); end

  def overwhelmed; %w{guilty sick angry afraid}[index]; end
  def exhausted; %w{misunderstood sore indebted stupid}[index]; end

  def input; %w{hear eat earn watch}[index]; end
  def output; %w{talk walk buy think}[index]; end

  def harvest; %w{listen\ to eat use look\ for}[index]; end
  def resource; %w{opinion food tool fact}[index]; end
  def resources; resource.s; end
  def harvest_resources; [harvest, resources].join(" "); end
  def triggers; %w{whines sweets weapons exceptions}[index]; end
  def neurochemicals; %w{oxytocin serotonin dopmaine adrenaline}[index]; end

  def hit; %w{tell go own understand}[index]; end
  def do_work; [hit, targets].join(" "); end

  def reject; %w{cry vomit fight panic}[index]; end
  def stall; %w{stammer stumble max\ out make\ mistakes}[index]; end

end
