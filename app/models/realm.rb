class Realm < Indexable

  ########
  IDENTIFIERS = %w{s t f n}
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

  def appear; choose Verb, %w{smell feel sound look}; end

  def consume; choose Verb, %w{eat earn listen watch}; end
  def consumer; consume.to_noun; end

  def consume_helper; choose Word, %w{NIL NIL to NIL }; end
  def consume_with; Phrase.optional consume, consume_helper; end

  def consume_time; choose Noun, %w{mealtime work\ time story\ time lesson\ time}; end

  def empty; choose Adjective, %w{hungry poor lonely curious}; end
  def full; choose Adjective, %w{restless rich loved sure}; end
  def ill; choose Adjective, %w{nauseous angry suicidal afraid}; end
  def worn_out; choose Adjective, %w{sore indebted misunderstood wrong}; end

  def produce; choose Verb, %w{travel shop talk think}; end
  def producer; produce.to_noun; end

  def produce_with; choose Verb, %w{go buy say predict}; end
  def thing; Noun.new(first? ? "place" : "thing"); end

  def produce_time; choose Noun, %w{travel\ time shopping\ time speech\ time test\ time}; end

  def waste; choose Verb, %w{pace splurge chatter guess}; end
end
