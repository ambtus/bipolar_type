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

  def consume; choose Verb, %w{eat look listen work}; end
  def consumer; consume.to_noun; end

  def consume_helper; choose Word, %w{NIL at to on }; end
  def consume_with; Phrase.optional consume, consume_helper; end

  def consume_time; choose Noun, %w{mealtime lesson\ time story\ time work\ time}; end

  def potential; choose Noun, %w{fat memories friends savings}; end

  def produce; choose Verb, %w{walk think talk shop}; end
  def producer; produce.to_noun; end

  def produce_with; choose Verb, %w{move predict say buy}; end

  def produce_time; choose Noun, %w{gym\ time test\ time speech\ time shopping\ time}; end

end
