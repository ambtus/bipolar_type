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

  def measurable; index.even? ? strengths : energy; end

  def amount; index < 2 ? measurable.fewer : "more"; end

  def result; Phrase.new [amount, measurable, "than average"]; end

  def love; behaviors[index]; end
  def hate; behaviors[(index + 1).modulo(4)]; end
  def dislike; behaviors[(index + 2).modulo(4)]; end
  def like; behaviors[(index + 3).modulo(4)]; end

  def manic; manic_results[index]; end
  def mania; Phrase.new [manic, "when manic"]; end

  def depressed; depressed_results[index]; end
  def depression; Phrase.new [depressed, "when depressed"]; end

  def cycle_result
    case index
    when 0
      "will eventually run out of potential energy during a manic episode"
    when 1
      "may run out of potential energy during a manic episode"
    when 2
      "strengths become more and more germane during every cycle"
    when 3
      "gets bigger and bigger during every cycle"
    end
  end

    def loses_energy; Phrase.new ["loses", energy]; end
    def gains_energy; Phrase.new ["gains", energy]; end
    def loses_strengths; Phrase.new ["less critical", strengths, "atrophy"]; end
    def gains_strengths; Phrase.new ["builds new", strengths]; end

  private
    def consume; Verb.new "consume"; end
    def produce; Verb.new "produce"; end
    def strengths; Noun.new "strengths"; end
    def energy; Noun.new "potential energy"; end

    def consume_energy; Phrase.new [consume, "energizers"]; end
    def consume_strength; Phrase.new [consume, "strengtheners" ]; end
    def energetic_production; Phrase.new [produce, "energetically"]; end
    def strong_production; Phrase.new [produce, "strongly"]; end

  def behaviors; [energetic_production, strong_production, consume_strength, consume_energy]; end
    def manic_results; [loses_energy, loses_energy, gains_strengths, gains_strengths]; end
    def depressed_results; [loses_strengths, gains_energy, loses_strengths, gains_energy]; end

end
