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
  def adverb; adjective + "ly"; end

  def energy; %w{affect glucose currency data}[index]; end
  def energetic; %w{moral caloric financial informational}[index]; end
  def an_energetic; [energetic.an, energetic].join(" "); end
  def reserves; %w{moods fat savings memories}[index]; end

  def goal; %w{person place thing idea}[index]; end
  def goals; goal.s; end
  def thing; %w{one where thing thing}[index]; end

  def do_work; %w{talk\ about walk\ around pay\ for think\ about}[index]; end
  def act; do_work.split.first; end
  def achieve; %w{influence visit build understand }[index]; end
  def achieve_goals; [achieve, goals].join(" "); end

  def sense; %w{hear smell touch see}[index]; end
  def harvest; %w{listen taste hold watch}[index]; end
  def process; %w{agree\ with eat use believe}[index]; end
  def resource; %w{opinion food tool fact}[index]; end
  def resources; resource.s; end
  def process_resources; [process, resources].join(" "); end

  def neurochemical; %w{oxytocin serotonin dopamine adrenaline}[index]; end

  def manic; %w{miserable disgusted angry afraid}[index]; end
  def mania; %w{misery disgust anger fear}[index]; end

  def depressed; %w{disliked sore indebted stupid}[index]; end

  def healthy; %w{loving nutritious useful symmetric}[index]; end
  def important; %w{nice fertile sturdy falsifiable}[index]; end

end
