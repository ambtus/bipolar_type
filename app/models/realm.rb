class Realm < Concept

  ADJECTIVES = %w{physical mental spiritual material}
  CONSUMES = %w{eat learn listen earn}
  PRODUCES = %w{move think talk spend}
  CONSUMEDS = %w{ate learned heard earned}
  PRODUCEDS = %w{done thought said bought}
  ORGANS = %w{body mind voice credit}
  ########

  ACRONYMS = %w{s n f t}
  ALL = ACRONYMS.collect {|letter| self.new letter}
  ACRONYMS.each do |letter|
    define_singleton_method(letter) {ALL[ACRONYMS.index(letter)]}
  end
  ########

  def siblings; Realm.all - [self]; end

  def subtypes; Subtype.all.select{|s| s.realm == self}; end
  def +(attitude); subtypes.find{|s| s.attitude == attitude}; end

  def adjective; ADJECTIVES[index]; end
  def adverb; adjective + "ly"; end
  def name; adjective.capitalize; end

  def energy; ENERGIES[index]; end
  def organ; ORGANS[index]; end

  def consume; CONSUMES[index]; end
  def overwhelmed; OVERWHELMEDS[index]; end
  def consumed; CONSUMEDS[index]; end
  def produce; PRODUCES[index]; end
  def produced; PRODUCEDS[index]; end

  def consuming; consume.gsub(/e$/, '') + "ing"; end
  def producing; produce.gsub(/e$/, '') + "ing"; end

  def self.consumes; ALL.map(&:consume).to_sentence; end
  def self.produces; ALL.map(&:produce).to_sentence; end

end
