class Realm < Indexable

  ADJECTIVES = %w{physical financial social mental}

  ########
  IDENTIFIERS = ADJECTIVES.map(&:first)
  def self.paths; IDENTIFIERS; end
  ALL = IDENTIFIERS.collect{|letter| self.new letter}
  all.each { |r| define_singleton_method(r.path) {all[IDENTIFIERS.index r.string]} }
  ########

  def mbti; choose Word, %w{S T F N}; end

  def subtypes; Subtype.all.select{|s| s.realm == self}; end
  def +(attitude); subtypes.find{|s| s.attitude == attitude} || Subtype.new([self, attitude]); end
  def quad; Quad.new Array.new(4, self).add(Attitude.all).map(&:path).join("-"); end

  def adjective; choose Adjective, ADJECTIVES; end
  def description; adjective; end
  def adverb; adjective.ly; end
  def name; adjective.capitalize; end

  def potential; choose Noun, %w{fat rewards emotions information}; end

  def consume; choose Verb, %w{eat work listen watch}; end
  def consume_helper; choose Word, %w{NIL on to NIL}; end
  def consume_with; Phrase.optional consume, consume_helper; end

  def produce; choose Verb, %w{walk buy talk predict}; end
  def produce_with; choose Verb, %w{do buy say predict}; end

end
