class Realm < Concept

  SYMBOLS = %w{A P F M}

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

  def adjective; %w{affective physical financial mental}[index]; end
  def adverb; adjective.ly; end

  def energy; %w{emotions calories money data}[index]; end
  def reserves; %w{hope fat savings knowledge}[index]; end
  def empty; %w{hopeless hungry overdrawn forgetful}[index]; end

  def consume; %w{listen eat compete see}[index]; end
  def process; %w{understand digest collect believe}[index]; end
  def resources; %w{feedback foods rewards results}[index]; end
  def process_resources; [process, resources].join(" "); end
  def process_the_resources; [process, "the", resources].join(" "); end

  def energizers; %w{music/intonation carbs cash\ rewards specific\ details}[index]; end
  def get; %w{listen\ to eat compete\ for look\ for}[index]; end
  def get_energy; [get, energizers].compact.join(" "); end
  def get_more_energy; [get, "more", energizers].compact.join(" "); end
  def get_less_energy; [get, energizers.last == "s" ? "fewer" : "less", energizers].compact.join(" "); end
  def strengtheners; %w{words/meaning protein prestige/respect patterns/outlines}[index]; end
  def get_more_strength; [get, "more", strengtheners].compact.join(" "); end

  def produce; %w{talk walk shop think}[index]; end
  def nouns; %w{people places things ideas}[index]; end
  def change; %w{influence go buy synthesize}[index]; end
  def change_nouns; [change, nouns].join(" "); end

  def strength; %w{words muscle credit logic}[index]; end
  def labor; %w{communicate exercise buy think}[index]; end
  def use_strength; ["use", strength].join(" "); end
  def use_more_strength; ["use more", strength].join(" "); end
  def use_less_strength; ["use", strength.last == "s" ? "fewer" : "less", strength].compact.join(" "); end
  def energies; %w{emotions reps cash facts}[index]; end
  def use_more_energy; ["use more", energies].join(" "); end


end
