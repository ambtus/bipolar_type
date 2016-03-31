class Realm < Indexable

  ########
  IDENTIFIERS = %w{s n f t}
  def self.paths; IDENTIFIERS; end
  ALL = IDENTIFIERS.collect{|letter| self.new letter}
  all.each { |r| define_singleton_method(r.path) {all[IDENTIFIERS.index r.string]} }
  ########

  def self.mbti_order(first, second); [first, second].sort.map(&:upcase).join ; end


  def +(attitude); subtypes.find{|s| s.attitude == attitude} || Subtype.new([self, attitude]); end
  def quad; Quad.new Array.new(4, path).join("-"); end
  def subtypes; Subtype.all.select{|s| s.realm == self}; end
  Attitude.all.each {|a| define_method(a.path) {self + a}}
  def generic_subtype; Subtype.new [self, Attitude.generic]; end

  def adjective; choose Adjective, %w{physical mental emotional financial}; end
  def adverb; adjective.ly; end

  def appear; choose Verb, %w{smell look sound feel}; end
  def good; choose Adjective, %w{sweet symmetric harmonic smooth}; end

  def consume; choose Verb, %w{eat look listen work}; end
  def consume_helper; choose Word, %w{NIL at to for}; end
  def consume_with; choose Verb, %w{eat see hear earn}; end
  def energizers; choose Noun, %w{carbs details tragedies cash}; end
  def strengtheners; choose Noun, %w{protein results rebuttals loan\ repayments}; end

  def recover; Phrase.new [consume_with, strengtheners]; end
  def energize; Phrase.new [consume_with, energizers]; end

  def kinetic; choose Noun, %w{calories facts emotions cash}; end
  def potential; choose Noun, %w{fat memories friends savings}; end

  def process_verb; choose Verb, %w{digest believe empathize collect}; end
  def process_helper; choose Verb, %w{NIL NIL with NIL}; end
  def resources; choose Noun, %w{food information stories rewards}; end
  def process; Phrase.new [process_verb, process_helper, "the", resources]; end

  def produce; choose Verb, %w{walk decide talk buy}; end
  def produce_with; choose Verb, %w{go predict say buy}; end
  def thing; Noun.new(first? ? "where" : "thing"); end
  def things; Noun.new(first? ? "places" : "things"); end

  def empty; choose Adjective, %w{hungry curious lonely poor}; end
  def worn_out; choose Adjective, %w{sore wrong misunderstood indebted}; end
  def full; Phrase.new [adverb, "full"]; end
  def restless; Phrase.new [adverb, "restless"]; end

end
