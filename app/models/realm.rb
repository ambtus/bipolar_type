class Realm < Indexable

  MBTI = %w{S N F T}
  ADJECTIVE = %w{physical mental social financial}
  PRODUCE = %w{move decide talk buy}
  CONSUME = %w{eat look listen earn}
  POTENTIAL = %w{fat memories friends savings}

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

  def produce; choose Verb, PRODUCE; end
  def consume; choose Verb, CONSUME; end

  def adjective; choose Adjective, ADJECTIVE; end
  def adverb; adjective.ly; end
  def name; adjective.capitalize; end

  def potential; choose Noun, POTENTIAL; end

end
