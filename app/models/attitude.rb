class Attitude < Indexable

  ########
  IDENTIFIERS = %w{ energetic dominant strong submissive }
  def self.paths; IDENTIFIERS; end
  ALL = IDENTIFIERS.collect{|letter| self.new letter}
  all.each { |a| define_singleton_method(a.path) {all[IDENTIFIERS.index a.string]} }
  ########

  def identifier; choose Adjective, IDENTIFIERS; end
  def name; identifier.titleize; end

  def subtypes; Subtype.all.select{|s| s.attitude == self}; end
  def generic_subtype; Subtype.new [Realm.generic, self]; end

  def preface; self.class::BEHAVIORS[index]; end
  def behavior; self.class::BEHAVIORS[index + 1]; end
  def result; choose Noun, %w{weak anorexic musclebound obese} ; end

  def rare; %w{worn_out full ready empty}[index] ; end

  class << self
  private
    def consume; Verb.new "consume"; end
    def energizers; Noun.new "energizers"; end
    def strengtheners; Noun.new "strengtheners"; end
    def produce; Verb.new "produce"; end
    def energetically; Word.new "energetically"; end
    def strongly; Word.new "strongly"; end

    def consume_energizers; Phrase.new [consume, energizers]; end
    def consume_strengtheners; Phrase.new [consume, strengtheners ]; end
    def produce_energetically; Phrase.new [produce, energetically]; end
    def produce_strongly; Phrase.new [produce, strongly ]; end
  end
  BEHAVIORS = [consume_energizers, produce_energetically, produce_strongly, consume_strengtheners, consume_energizers]
end
