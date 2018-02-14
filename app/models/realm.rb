class Realm < Concept

  ADJECTIVES = %w{physical mental emotional financial}
  ENERGIES = %w{calories facts opinions assets}
  EASIES = %w{walk guess talk rent}
  HARDS = %w{run prove yell buy}
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

  def energy; ENERGIES[index]; end
  def easy; EASIES[index]; end
  def hard; HARDS[index]; end

  def easying; easy + "ing"; end
  def harding; (hard + "ing").gsub("ni", "nni").gsub("ein", "in"); end

  def name; adjective.capitalize; end

end
