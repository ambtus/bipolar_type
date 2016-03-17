class Realm < Indexable

  ########
  IDENTIFIERS = %w{s n f t}
  def self.paths; IDENTIFIERS; end
  ALL = IDENTIFIERS.collect{|letter| self.new letter}
  all.each { |r| define_singleton_method(r.path) {all[IDENTIFIERS.index r.string]} }
  ########


  def +(attitude); subtypes.find{|s| s.attitude == attitude} || Subtype.new([self, attitude]); end
  def quad; Quad.new Array.new(4, path).join; end
  def subtypes; Subtype.all.select{|s| s.realm == self}; end
  Attitude.all.each {|a| define_method(a.path) {self + a}}
  def generic_subtype; Subtype.new [self, Attitude.generic]; end


  def sensory; choose Adjective, %w{ gustatory visual auditory tactile}; end
  def organ; choose Noun, %w{ nose eyes ears fingers }; end
  def adjective; choose Adjective, %w{ physical mental social financial}; end

  def consume; choose Verb, %w{ eat watch listen earn }; end
  def resources; choose Noun, %w{foods sights stories wages }; end
  def appear; choose Verb, %w{taste looks sound feel }; end
  def appearance; appear; end

  def produce; choose Verb, %w{ walk predict talk spend }; end

  def potential; choose Noun, %w{fat memories friendships savings }; end
  def energy; choose Noun, %w{calories facts emotions cash }; end

  def obvious; choose Adjective, %w{aromatic colorful loud hard-earned }; end
  def subtle; choose Adjective, %w{bland grey harmonious easy }; end

  def sick; choose Adjective, %w{nauseous afraid hysterical angry };end

  def be_sick_verb; choose Verb, %w{throw panic cry gamble };end
  def be_sick_helper; choose Word, %w{up NIL NIL NIL};end
  def be_sick; Phrase.optional be_sick_verb, be_sick_helper; end

  def worn_out; choose Adjective, %w{sore wrong misunderstood indebted}; end
  def strengths; choose Noun, %w{muscles logic values  loans }; end

end
