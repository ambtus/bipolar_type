class Realm < Indexable

  ADJECTIVES = %w{physical mental social financial}

  ########
  #IDENTIFIERS = %w{s n f t}
  IDENTIFIERS = ADJECTIVES.map(&:first)
  def self.paths; IDENTIFIERS; end
  ALL = IDENTIFIERS.collect{|letter| self.new letter}
  all.each { |r| define_singleton_method(r.path) {all[IDENTIFIERS.index r.string]} }
  ########

  def mbti_order(second); [self, second].sort.map(&:upcase).join ; end

  def quad; Quad.new Array.new(4, path).join; end

  def subtypes; Subtype.all.select{|s| s.realm == self}; end
  def +(attitude); subtypes.find{|s| s.attitude == attitude} || Subtype.new([self, attitude]); end

  def generic_subtype; Subtype.new [self, Attitude.generic]; end

  def adjective; choose Adjective, ADJECTIVES; end
  def adverb; adjective.ly; end
  def name; adjective.capitalize; end

  def energy; choose Noun, %w{fat memories emotions savings}; end

  def consume; choose Verb, %w{eat watch listen work}; end
  def produce; choose Verb, %w{move think talk play}; end

  def overwhelmed; choose Verb, %w{nauseous anxious upset frustrated}; end
  def worn_out; choose Verb, %w{sore stupid misunderstood indebted}; end

end
