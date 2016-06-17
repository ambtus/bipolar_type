class Realm < Indexable

  MBTI = %w{S N F T}
  ADJECTIVE = %w{physical mental spiritual financial}
  CONSUME = %w{eat watch listen work}
  PRODUCEV = %w{walk decide talk spend}
  PRODUCEO = %w{NIL NIL NIL money}
  PVERB = %w{visit solve influence buy}
  NOUNS = %w{places problems people assets}
  THING = %w{where thing one thing}
  KINETIC = %w{glycogen facts emotions cash}
  POTENTIAL = %w{fat memories attachments savings}
  CVERB = %w{eat see listen earn}
  PREPOSITION = %w{NIL NIL to NIL}
  OBVIOUS = %w{flavorful bright loud painful}
  IMPACTFUL = %w{high-carb detailed tragic risky}
  OBJECTS = %w{meals pictures stories rewards}
  STRENGTHENERS = %w{protein patterns happy\ endings repayments}
  OVERWHELMED = %w{nauseous afraid suicidal angry}
WHELM = %w{vomit panic suicide fight}
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

  def both(subtype); [self, subtype.realm].sort.map(&:mbti).join; end

  def whelm; choose Verb, WHELM; end
  def producev; choose Verb, PRODUCEV; end
  def produced; choose Verb, PRODUCED; end
  def consume; choose Verb, CONSUME; end
  def cverb; choose Verb, CVERB; end
  def produce_verb; choose Verb, PVERB; end
  def produce_verb2; choose Verb, PVERB2; end
  def preposition; choose Word, PREPOSITION; end
  def produceo; choose Word, PRODUCEO; end

  def adjective; choose Adjective, ADJECTIVE; end
  def obvious; choose Adjective, OBVIOUS; end
  def impactful; choose Adjective, IMPACTFUL; end
  def overwhelmed; choose Adjective, OVERWHELMED; end
  def worn; choose Adjective, WORN; end

  def mbti; choose Noun, MBTI; end
  def kinetic; choose Noun, KINETIC; end
  def potential; choose Noun, POTENTIAL; end
  def objects; choose Noun, OBJECTS; end
  def strengtheners; choose Noun, STRENGTHENERS; end
  def nouns; choose Noun, NOUNS; end
  def thing; choose Noun, THING; end

  def adverb; adjective.ly; end
  def triggers; Phrase.new [obvious.comma, impactful, objects]; end
  def produce; Phrase.optional producev, produceo; end
  def consume_verb; Phrase.optional cverb, preposition; end
  def consume_triggers; Phrase.new [consume_verb, triggers]; end
  def name; Phrase.new [adjective.capitalize, mbti.parenthesize]; end

  def over_production; Phrase.new ["There are more", nouns, "I want to", produce_verb]; end
  def under_production; Phrase.new ["I don’t want to", produce_verb, "any more", nouns]; end
  def over_sensitivity; Phrase.new ["I don’t want to", consume_verb, "any more", objects]; end
  def under_sensitivity; Phrase.new ["There are more", objects, "I want to", consume_verb]; end
end
