class Realm < Indexable

  MBTI = %w{S N F T}
  NEURO = %w{serotonin epinephrine oxytocin dopamine}
  SENSORY = %w{olfactory visual auditory tactile}
  ADJECTIVE = %w{physical mental interpersonal financial}
  CONSUMEWO = %w{eat see hear use}
  FOCUS = %w{action truth story tools}
  APPEAR = %w{taste look sound feel}
  STRENGTH = %w{protein outlines words power}
  GOOD = %w{sweet colorful loving useful}
  ENERGY = %w{carbs details voices features}
  APPEARANCES = %w{flavors colors intonations textures}
  STRESSED = %w{nauseous anxious crying frustrated}
  OVERSTRESSED = %w{sick afraid suicidal angry}
  REJECT = %w{vomit panic suicide fight}
  EXCESS = %w{fat trivia attachments junk}
  CONSUME = %w{eat learn listen work}
  PRODUCE = %w{move think talk achieve}
  WORN = %w{sore stupid misunderstood unsuccessful}

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
  def consume; choose Verb, CONSUME; end
  def consume_with_object; choose Verb, CONSUMEWO; end
  def appear; choose Verb, APPEAR; end
  def reject; choose Verb, REJECT; end

  def adjective; choose Adjective, ADJECTIVE; end
  def worn; choose Adjective, WORN ; end
  def stressed; choose Adjective, STRESSED ; end
  def overstressed; choose Adjective, OVERSTRESSED ; end
  def neuro; choose Adjective, NEURO ; end
  def sensory; choose Adjective, SENSORY ; end
  def good; choose Adjective, GOOD ; end

  def mbti; choose Noun, MBTI; end
  def excess; choose Noun, EXCESS; end
  def energy; choose Noun, ENERGY; end
  def strength; choose Noun, STRENGTH; end
  def focus; choose Noun, FOCUS; end
  def appearances; choose Noun, APPEARANCES; end

  def gives; energy.uncountable? ? "gives" : "give"; end
  def adverb; adjective.ly; end
  def name; Phrase.new [adverb.capitalize.colon, "focus on", focus, mbti.parenthesize]; end

  def basic; Phrase.new [consume_with_object.capitalize, strength.more_phrase, "when you feel", worn]; end

end
