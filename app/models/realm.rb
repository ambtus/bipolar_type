class Realm < Indexable

  ADJECTIVES = %w{physical mental social financial}

  ########
  IDENTIFIERS = ADJECTIVES.map(&:first)
  def self.paths; IDENTIFIERS; end
  ALL = IDENTIFIERS.collect{|letter| self.new letter}
  all.each { |r| define_singleton_method(r.path) {all[IDENTIFIERS.index r.string]} }
  ########

  def mbti; choose Word, %w{S N F T}; end
  def mbti_order(second); [self, second].sort.map(&:mbti).join ; end

  def quad; Quad.new Array.new(4, path).join; end

  def subtypes; Subtype.all.select{|s| s.realm == self}; end
  def +(attitude); subtypes.find{|s| s.attitude == attitude} || Subtype.new([self, attitude]); end

  def generic_subtype; Subtype.new [self, Attitude.generic]; end

  def adjective; choose Adjective, ADJECTIVES; end
  def description; adjective; end
  def adverb; adjective.ly; end
  def name; adjective.capitalize; end

  def get; choose Verb, %w{ingest see hear achieve}; end
  def use; choose Verb, %w{burn predict tell buy}; end
  def kinetic; choose Noun, %w{calories truths stories results}; end
  def potential; choose Noun, %w{fat memories empathy money}; end

  def object; choose Noun, %w{weight facts friends savings}; end
  def lose_verb; choose Verb, %w{lose forget lose lose}; end
  def gain_verb; choose Verb, %w{gain remember make gain}; end
  def lose; Phrase.optional lose_verb, object; end
  def gain; Phrase.optional gain_verb, object; end

  def consume; Phrase.new [get, kinetic]; end
  def produce; Phrase.new [use, kinetic]; end

  def overwhelmed; choose Verb, %w{nauseous anxious upset frustrated}; end

  def reject_verb; choose Verb, %w{throw panic cry get}; end
  def reject_helper; choose Word, %w{up NIL NIL angry}; end
  def reject; Phrase.optional reject_verb, reject_helper; end

  def worn_out; choose Verb, %w{sore wrong misunderstood indebted}; end

end
