class Realm < Indexable

  MBTI = %w{S N F T}
  ADJECTIVE = %w{physical mental emotional financial}
  CONSUME = %w{eat watch listen work}
  PRODUCE = %w{move decide talk spend}
  PVERB = %w{do decide say buy}
  KINETIC = %w{glycogen facts emotions cash}
  POTENTIAL = %w{fat memories friends savings}
  CVERB = %w{eat see hear earn}
  PREPOSITION = %w{NIL NIL NIL NIL}
  OBVIOUS = %w{flavorful bright loud painful}
  IMPACTFUL = %w{high-carb changing repetitive well-paid}
  OBJECTS = %w{meals colors voices rewards}
  OVERWHELMED = %w{nauseous afraid suicidal angry}
  WORN = %w{sore stupid misunderstood indebted}

  ########
  LETTERS = MBTI.map(&:downcase)
  def self.paths; LETTERS; end
  ALL = LETTERS.collect{|letter| self.new letter}
  def self.all; ALL; end
  LETTERS.each do |letter|
    define_singleton_method(letter) { ALL[LETTERS.index(letter)] }
  end
  ########

  def subtypes; Subtype.all.select{|s| s.realm == self}; end
  def +(attitude); subtypes.find{|s| s.attitude == attitude} || Subtype.new([self, attitude]); end
  def quad; Quad.new Array.new(4, self).map(&:path).join; end

  def produce; choose Verb, PRODUCE; end
  def produced; choose Verb, PRODUCED; end
  def consume; choose Verb, CONSUME; end
  def cverb; choose Verb, CVERB; end
  def produce_verb; choose Verb, PVERB; end
  def preposition; choose Word, PREPOSITION; end

  def adjective; choose Adjective, ADJECTIVE; end
  def obvious; choose Adjective, OBVIOUS; end
  def impactful; choose Adjective, IMPACTFUL; end
  def overwhelmed; choose Adjective, OVERWHELMED; end
  def worn; choose Adjective, WORN; end

  def mbti; choose Noun, MBTI; end
  def kinetic; choose Noun, KINETIC; end
  def potential; choose Noun, POTENTIAL; end
  def objects; choose Noun, OBJECTS; end

  def adverb; adjective.ly; end
  def triggers; Phrase.new [obvious.comma, impactful, objects]; end
  def consume_verb; Phrase.optional cverb, preposition; end
  def consume_triggers; Phrase.new [consume_verb, triggers]; end
  def name; Phrase.new [adjective.capitalize, mbti.parenthesize]; end

end
