class Attitude < Indexable

  ########
  IDENTIFIERS = %w{weak anorexic musclebound obese}
  def self.paths; IDENTIFIERS; end
  ALL = IDENTIFIERS.collect{|letter| self.new letter}
  all.each { |a| define_singleton_method(a.path) {all[IDENTIFIERS.index a.string]} }
  ########

  def identifier; choose Adjective, IDENTIFIERS; end
  def name; identifier.titleize; end

  def subtypes; Subtype.all.select{|s| s.attitude == self}; end
  def generic_subtype; Subtype.new [Realm.generic, self]; end

  def loved_behavior; self.class::BEHAVIORS[index]; end
  def hated_behavior; self.class::BEHAVIORS[(index + 1).modulo(4)]; end
  def disliked_behavior; self.class::BEHAVIORS[(index + 2).modulo(4)]; end
  def liked_behavior; self.class::BEHAVIORS[(index + 3).modulo(4)]; end

  class << self
  private
    def consume; Verb.new "consume"; end
    def energy; Noun.new "energy"; end
    def strength; Noun.new "strength"; end

    def energetic; Adjective.new "energetic"; end
    def strong; Adjective.new "strong"; end
    def production; Noun.new "production"; end

    def consume_energy; Phrase.new [consume, energy]; end
    def consume_strength; Phrase.new [consume, strength ]; end
    def energetic_production; Phrase.new [energetic, production]; end
    def strong_production; Phrase.new [strong, production]; end
  end
  BEHAVIORS = [energetic_production, strong_production, consume_strength, consume_energy]
end
