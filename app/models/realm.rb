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

  def get_energy; Phrase.new [Verb.new("take"), "in"]; end
  def get_them; Phrase.new [Verb.new("take"), energy.them, "in"]; end
  def energy; choose Noun, %w{calories facts stories rewards}; end
  def use_energy; Phrase.new [Verb.new("use"), "up"]; end
  def use_them; Phrase.new [Verb.new("use"), energy.them, "up"]; end

  def consume; choose Verb, %w{eat learn listen earn}; end
  def consumer; consume.to_noun; end
  def consume_helper; choose Word, %w{NIL NIL to NIL }; end
  def consume_with; Phrase.optional consume, consume_helper; end

  def produce; choose Verb, %w{move decide talk spend}; end
  def producer; produce.to_noun; end
  def produce_with; choose Verb, %w{do decide say buy}; end
  def worn_out; choose Adjective, %w{sore wrong misunderstood indebted }; end

  def low; choose Adjective, %w{hungry curious bored poor }; end
  def high; choose Adjective, %w{restless sure excited entitled }; end
  def ill; choose Adjective, %w{nauseous anxious upset frustrated }; end
  def very_ill; choose Adjective, %w{violently\ ill terrified suicidal homicidal }; end

end
