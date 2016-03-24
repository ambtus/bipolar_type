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

  def adjective; choose Adjective, %w{physical mental social financial }; end
  def adverb; adjective.ly; end
  def name; adjective.capitalize; end

  def consume; choose Verb, %w{eat look listen work}; end
  def consumer; consume.to_noun; end
  def consume_helper; choose Word, %w{NIL at to NIL }; end
  def consume_with; Phrase.optional consume, consume_helper; end

  def produce; choose Verb, %w{move guess talk spend}; end
  def producer; produce.to_noun; end
  def produce_with; choose Verb, %w{do guess say buy}; end
  def strengths; choose Adjective, %w{muscles brain vocabulary credit }; end
  def worn_out; choose Adjective, %w{sore stupid misunderstood indebted }; end

  def low; choose Adjective, %w{hungry curious bored poor }; end
  def high; choose Adjective, %w{restless sure emotional entitled }; end
  def ill; choose Adjective, %w{nauseous anxious unhappy frustrated }; end
  def very_ill; choose Adjective, %w{violently\ ill afraid suicidal angry }; end

end
