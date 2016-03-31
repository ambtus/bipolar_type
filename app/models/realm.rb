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
  def consume_with; choose Verb, %w{eat see hear earn}; end
  def energy; choose Adjective, %w{carbs facts music cash}; end
  def potential; choose Noun, %w{fat memories emotions savings}; end

  def process; choose Verb, %w{digest believe understand collect}; end

  def produce; choose Verb, %w{walk decide talk shop}; end
  def produce_with; choose Verb, %w{go decide say buy}; end
  def thing; Noun.new(first? ? "place" : "thing"); end

  def worn_out; choose Adjective, %w{sore stupid misunderstood indebted}; end

end
