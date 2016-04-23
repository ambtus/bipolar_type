class Realm < Indexable

  ########
  IDENTIFIERS = %w{s n f t}
  def self.paths; IDENTIFIERS; end
  ALL = IDENTIFIERS.collect{|letter| self.new letter}
  all.each { |r| define_singleton_method(r.path) {all[IDENTIFIERS.index r.string]} }
  ########

  def mbti_order(second); [self, second].sort.map(&:upcase).join ; end

  def +(attitude); subtypes.find{|s| s.attitude == attitude} || Subtype.new([self, attitude]); end
  def quad; Quad.new Array.new(4, path).join("-"); end
  def subtypes; Subtype.all.select{|s| s.realm == self}; end
  Attitude.all.each {|a| define_method(a.path) {self + a}}
  def generic_subtype; Subtype.new [self, Attitude.generic]; end

  def adjective; choose Adjective, %w{physical mental emotional financial}; end
  def adverb; adjective.ly; end
  def name; adjective.capitalize; end

  def consume; choose Verb, %w{eat look listen work}; end
  def produce; choose Verb, %w{move decide talk buy}; end

  def big; Phrase.new [adverb, "fat"]; end
  def small; Phrase.new [adverb, "skinny"]; end
  def weak; Phrase.new [adverb, "weak"]; end
  def strong; Phrase.new [adverb, "strong"]; end
end
