class Realm < Concept

  ADJECTIVES = %w{physical mental emotional financial}
  CONSUMES = %w{eat watch listen earn}
  PRODUCES = %w{walk think talk spend}
  CONSUMEDS = %w{ate saw heard earned}
  ORGANS = %w{body mind voice credit}
  ########

  ACRONYMS = ADJECTIVES.map(&:first)
  ALL = ACRONYMS.collect {|letter| self.new letter}
  ACRONYMS.each do |letter|
    define_singleton_method(letter) {ALL[ACRONYMS.index(letter)]}
  end
  ########

  def subtypes; Subtype.all.select{|s| s.realm == self}; end
  def +(attitude); subtypes.find{|s| s.attitude == attitude}; end

  def adjective; ADJECTIVES[index]; end
  def adverb; adjective + "ly"; end
  def name; adjective.capitalize; end

  def energy; ENERGIES[index]; end
  def organ; ORGANS[index]; end

  def consume; CONSUMES[index]; end
  def consumed; CONSUMEDS[index]; end
  def produce; PRODUCES[index]; end

  def consuming; consume + "ing"; end
  def producing; produce + "ing"; end

  def self.consumings; ALL.map(&:consuming).to_sentence; end
  def self.producings; ALL.map(&:producing).to_sentence; end

end
