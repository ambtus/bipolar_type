class Attitude < Indexable

  ########
  IDENTIFIERS = %w{energetic producer strong consumer}
  def self.paths; IDENTIFIERS; end
  ALL = IDENTIFIERS.collect{|letter| self.new letter}
  all.each { |a| define_singleton_method(a.path) {all[IDENTIFIERS.index a.string]} }
  ########

  def identifier; choose Adjective, IDENTIFIERS; end
  def name; identifier.titleize; end

  def subtypes; Subtype.all.select{|s| s.attitude == self}; end
  def generic_subtype; Subtype.new [Realm.generic, self]; end

  def measurable; index.even? ? self.class.strengths : self.class.energy; end

  def amount; index < 2 ? measurable.fewer : "more"; end

  def result; Phrase.new [amount, measurable, "than average"]; end

  def love; self.class::BEHAVIORS[index]; end
  def hate; self.class::BEHAVIORS[(index + 1).modulo(4)]; end
  def dislike; self.class::BEHAVIORS[(index + 2).modulo(4)]; end
  def like; self.class::BEHAVIORS[(index + 3).modulo(4)]; end

  def manic; self.class::MANIC_RESULTS[index]; end
  def mania; Phrase.new [manic, "when manic"]; end

  def depressed; self.class::DEPRESSED_RESULTS[index]; end
  def depression; Phrase.new [depressed, "when depressed"]; end

  def cycle_result
    case index
    when 0
      "will eventually run out of potential energy during a manic episode"
    when 1
      "may run out of potential energy during a manic episode"
    when 2
      "strengths become more and more useful during every cycle"
    when 3
      "gets bigger and bigger during every cycle"
    end
  end

  class << self
    def consume; Verb.new "consume"; end
    def produce; Verb.new "produce"; end
    def strengths; Noun.new "strengths"; end
    def energy; Noun.new "potential energy"; end

    def consume_energy; Phrase.new [consume, "energizers"]; end
    def consume_strength; Phrase.new [consume, "strengtheners" ]; end
    def energetic_production; Phrase.new [produce, "energetically"]; end
    def strong_production; Phrase.new [produce, "strongly"]; end

    def loses_energy; Phrase.new ["loses", energy]; end
    def gains_energy; Phrase.new ["gains", energy]; end
    def loses_strengths; Phrase.new ["unused", strengths, "atrophy"]; end
    def gains_strengths; Phrase.new ["builds new", strengths]; end
  end
  BEHAVIORS = [energetic_production, strong_production, consume_strength, consume_energy]
  MANIC_RESULTS = [loses_energy, loses_energy, gains_strengths, gains_strengths]
  DEPRESSED_RESULTS = [loses_strengths, gains_energy, loses_strengths, gains_energy]
end
