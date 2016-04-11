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
  def name; adjective.capitalize; end

  def fat; choose Adjective, %w{fat knowledgeable social rich}; end
  def thin; choose Adjective, %w{skinny theoretical independent poor}; end
  def strong; choose Adjective, %w{strong smart influential creditworthy }; end
  def weak; choose Adjective, %w{weak stupid uninfluential uncreditworthy }; end

  def consume; choose Verb, %w{eat learn listen earn}; end
  def produce; choose Verb, %w{move decide talk spend}; end
  def unproductive; choose Verb, %w{seated undecided silent miserly}; end

  def reject_verb; choose Verb, %w{throw panic cry quit}; end
  def reject_helper; choose Word, %w{up NIL NIL NIL}; end
  def reject; Phrase.optional reject_verb, reject_helper; end

  def energizers; choose Noun, %w{carbs colors complaints cash}; end
  def potential; choose Noun, %w{fat memories friends money}; end

  def worn_out; choose Adjective, %w{sore stupid misunderstood indebted}; end
  def strengths; choose Noun, %w{muscles mental\ models vocabulary loans}; end
  def atrophy; strengths.uncountable? ? "atrophies" : "atrophy"; end
  def strengtheners; choose Noun, %w{protein results rebuttals repayments}; end

  def empty; choose Adjective, %w{hungry unsure lonely poor}; end
  def worn_out; choose Adjective, %w{sore wrong misunderstood indebted}; end

  def reject_verb; choose Verb, %w{throw panic cry quit}; end
  def reject_helper; choose Word, %w{up NIL NIL NIL}; end
  def reject; Phrase.optional reject_verb, reject_helper; end

end
