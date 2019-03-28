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
  def energetic; %w{confidence caloric financial informational}[index]; end
  def an_energetic; [energetic.an, energetic].join(" "); end
  def reserves; %w{self-esteem fat savings knowledge}[index]; end
  def many_reserves; [reserves.many, reserves].join(" "); end

  def goal; %w{person place thing idea}[index]; end
  def goals; goal.s; end
  def thing; %w{one where thing thing}[index]; end
  def question; %w{who where what what}[index]; end

  def achieve; %w{talk\ to walk\ around buy think\ about}[index]; end
  def use_energy; achieve.first_word; end
  def achieve_goals; [achieve, goals].join(" "); end

  def resource; %w{opinion food tool fact}[index]; end
  def resources; resource.s; end

  def sense; %w{hear smell touch see}[index]; end
  def harvest; %w{listen\ to eat work\ with look\ at}[index]; end
  def harvest_resources; [harvest, resources].join(" "); end

  def get_energy; harvest.first_word; end
  def process; %w{agree\ with digest use believe}[index]; end
  def process_energy; [process, resources].join(" "); end
  def reject_toxic_resources; %w{cry vomit fight panic}[index]; end

  def triggers; %w{whines carbs weapons colors}[index]; end
  def neurochemical; %w{oxytocin serotonin dopamine epinephrine}[index]; end

  def emotion; %w{misery disgust anger fear}[index]; end
  def emotional; %w{miserable disgusted angry afraid}[index]; end
  def mild_emotion; %w{unhappy nauseous irritated anxious}[index]; end

  def strength; %w{vocabulary muscles credit logic}[index]; end
  def much_strength; [strength.much, strength].join(" "); end
  def exhausted; %w{inarticulate sore indebted stupid}[index]; end
  def attempt; %w{influence go buy consider}[index]; end
  def restful; %w{quiet seated frugal baffled}[index]; end
  def rest; "remain #{restful}"; end

  def empty; %w{ashamed hungry poor unsure}[index]; end
  def full; %w{proud satisfied rich confident}[index]; end
  def appear; %w{sound taste feel look}[index]; end
  def healthy; %w{loving savory useful verifiable}[index]; end

  alias hyperactive :use_energy
  alias lazy :goals
  alias picky :resources
  alias greedy :get_energy

  def fat; %w{conceited fat rich trivial}[index]; end
  def skinny; %w{humble skinny poor ignorant}[index]; end

  def provided_for; %w{told\ to cooked\ for made\ for shown\ to}[index]; end
  def real; %w{listening outside tangible visible}[index]; end
end
