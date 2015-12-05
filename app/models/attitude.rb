class Attitude < Indexable

  ########
  LETTERS = %w{eX Xe Xi iX}
  ALL = LETTERS.collect{|letter| self.new letter}
  ########

  def subtype_string(realm); string.gsub("X", realm.string); end

  def subtypes; Subtype.all.select{|s| s.attitude == self}; end

  def self.paths; all.map(&:path); end
  self.paths.each_with_index { |path, index| define_singleton_method(path) {ALL[index]} }

  def domain_adjective; choose Adjective, %w{insensitive insensitive sensitive sensitive}; end
  def domain_noun; choose Noun, %w{explorer homebody explorer homebody}; end
  def domain; Phrase.new [domain_adjective, domain_noun]; end
  def name; Phrase.new [domain.titleize, parenthesize]; end

  AFFECTS = %w{wonderful bad good horrible}
  def manic_affect; Adjective.new AFFECTS[index]; end
  def depressed_affect; Adjective.new AFFECTS.reverse[index]; end

end
