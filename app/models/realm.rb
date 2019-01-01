class Realm < Concept

  SYMBOLS = %w{P M F A}

  ########
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  PATHS.each do |path|
    define_singleton_method(path) {ALL[PATHS.index(path)]}
  end
  %w{first second third fourth}.each_with_index do |ordinal, index|
    define_singleton_method(ordinal) {ALL[index]}
  end
  ########

  def subtypes; Subtype.all.select{|s| s.realm == self}; end
  def +(attitude); subtypes.find{|s| s.attitude == attitude}; end

  def adjective; %w{physical mental financial affective}[index]; end
  def adverb; adjective.ly; end

  def energy; %w{calories data money emotions}[index]; end
  def reserves; %w{fat knowledge savings hope}[index]; end
  def empty; %w{hungry forgetful overdrawn hopeless}[index]; end

  def produce; %w{walk think shop talk}[index]; end
  def nouns; %w{places ideas things people}[index]; end
  def change; %w{go synthesize buy influence}[index]; end
  def change_nouns; [change, nouns].join(" "); end

  def consume; %w{eat watch compete listen}[index]; end
  def process; %w{digest remember earn understand}[index]; end
  def resources; %w{foods truths rewards values}[index]; end
  def process_resources; [process, resources].join(" "); end
  def process_the_resources; [process, "the", resources].join(" "); end

  def nice; %w{sweet colorful cash musical}[index]; end
  def energizers; %w{carbs details rewards voices}[index]; end
  def get; %w{eat look\ for compete\ for listen\ to}[index]; end
  def get_energy; [get, energizers].compact.join(" "); end
  def get_more_energy; [get, "more", energizers].compact.join(" "); end
  def get_less_energy; [get, energizers.last == "s" ? "fewer" : "less", energizers].compact.join(" "); end
  def get_nice_energy; [get, nice, energizers].compact.join(" "); end
  def strengtheners; %w{protein patterns prestige/respect words/meaning}[index]; end
  def get_strength; [get, strengtheners].compact.join(" "); end

  def strength; %w{muscles logic credit vocabulary}[index]; end
  def labor; %w{exercise think buy communicate}[index]; end
  def use_less_strength; ["use", strength.last == "s" ? "fewer" : "less", strength].compact.join(" "); end
  def energies; %w{reps specific\ examples cash emotions}[index]; end
  def use_more_energy; ["use more", energies].join(" "); end


end
