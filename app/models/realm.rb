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

  def energizers; choose Noun, %w{sweets facts whines cash}; end
  def reject_verb; choose Verb, %w{throw panic cry quit}; end
  def reject_helper; choose Word, %w{up NIL NIL NIL}; end
  def reject; Phrase.optional reject_verb, reject_helper; end
  def kinetic; choose Noun, %w{glycogen facts emotions cash}; end
  def potential; choose Noun, %w{fat memories friends savings}; end
  def empty; choose Adjective, %w{hungry unsure lonely miserly}; end
  def death; choose Adjective, %w{starvation stupidity suicide exposure}; end
  def big; choose Adjective, %w{fat knowledgeable opinionated rich}; end
  def thin; choose Adjective, %w{skinny theoretical alone cash\ poor}; end

  def strengtheners; choose Noun, %w{protein patterns words repayments}; end
  def strengths; choose Noun, %w{muscles rules metaphors credit}; end
  def atrophy; strengths.uncountable? ? "atrophies" : "atrophy"; end
  def worn_out; choose Adjective, %w{sore wrong misunderstood indebted}; end
  def strong; choose Adjective, %w{strong smart eloquent good\ credit }; end
  def weak; choose Adjective, %w{weak stupid uninfluential bad\ credit }; end
  def am; choose Verb, %w{am am am have}; end
  def are; choose Verb, %w{are are are have}; end
  def are_weak; Phrase.new [are, weak]; end

  def consume; choose Verb, %w{eat watch listen work}; end
  def helper; choose Word, %w{NIL for to for}; end
  def consume_with; Phrase.optional consume, helper; end
  def produce; choose Verb, %w{move decide talk buy}; end
  def unproductive; choose Verb, %w{seated undecided silent miserly}; end

end
