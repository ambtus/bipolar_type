class Realm < Indexable

  MBTI = %w{S N F T}
  ADJECTIVE = %w{physical mental social financial}
  PRODUCE = %w{move predict talk buy}
  STRONG = %w{strong smart eloquent wealthy}
  CONSUME = %w{eat learn listen work}
  RESOURCE = %w{food theories stories paychecks}
  STRENGTH = %w{protein patterns words credit}
  SHORT = %w{carbs facts emotions cash}
  LONG = %w{fat memories values savings}
  USE = %w{burn forget express spend}
  STRENGTHS = %w{muscles rules metaphors assets}
  WEAK = %w{sore stupid misunderstood indebted}
  EMPTY = %w{hungry curious lonely broke}
  FULL = %w{restless confident emotional rich}
  OVERWHELMED = %w{nauseous anxious upset frustrated}
  REJECT = %w{vomit panic cry fight}

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

  def mbti; choose Word, MBTI; end

  def adjective; choose Adjective, ADJECTIVE; end
  def strong; choose Adjective, STRONG; end
  def weak; choose Adjective, WEAK; end
  def empty; choose Adjective, EMPTY; end
  def full; choose Adjective, FULL; end
  def overwhelmed; choose Adjective, OVERWHELMED; end

  def produce; choose Verb, PRODUCE; end
  def consume; choose Verb, CONSUME; end
  def use; choose Verb, USE; end
  def reject; choose Verb, REJECT; end

  def resource; choose Noun, RESOURCE; end
  def strength; choose Noun, STRENGTH; end
  def short; choose Noun, SHORT; end
  def long; choose Noun, LONG; end
  def strengths; choose Noun, STRENGTHS; end

  def adverb; adjective.ly; end
  def name; adjective.capitalize; end

end
