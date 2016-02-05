class Realm < Indexable

  ########
  IDENTIFIERS = %w{physical spiritual mental financial}
  def self.paths; IDENTIFIERS; end
  ALL = IDENTIFIERS.collect{|letter| self.new letter}
  all.each { |r| define_singleton_method(r.path) {all[IDENTIFIERS.index r.string]} }
  ########

  def subtypes; Subtype.all.select{|s| s.realm == self}; end
  def +(attitude)
    subtypes.find{|s| s.attitude == attitude} || Subtype.new([self, attitude])
  end
  Attitude.all.each {|a| define_method(a.path) {self + a}}

  def neuro; choose Adjective, %w{serotonin oxytocin GABA dopamine}; end

  def identifier; choose Adjective, IDENTIFIERS; end
  def name; identifier.titleize; end

  def consume_verb; choose Verb, %w{eat listen look work }; end
  def consume_helper; choose Word, %w{NIL to at on }; end
  def consume; Phrase.optional consume_verb, consume_helper; end

  def strengtheners; choose Noun, %w{protein stories patterns chores }; end
  def energizers; choose Noun, %w{carbs music details projects }; end

  def consume_energizers; Phrase.new [consume, energizers]; end
  def consume_strengtheners; Phrase.new [consume, strengtheners]; end

  def pev; choose Verb, %w{go express solve spend }; end
  def pen; choose Noun, %w{places emotions problems cash }; end
  def produce_energetically; Phrase.new [pev, pen]; end

  def psv; choose Verb, %w{lift influence prevent use }; end
  def psn; choose Noun, %w{weights people problems credit }; end
  def produce_strongly; Phrase.new [psv, psn]; end

  def produce; choose Verb, %w{move communicate think shop }; end

  def strengths; choose Noun, %w{muscles relationships rules credit }; end
  def energy; choose Noun, %w{fat hope memories savings }; end

  def atrophy; strengths.uncountable? ? "atrophies" : "atrophy"; end
  def become; strengths.uncountable? ? "becomes" : "become"; end

  def organ; choose Noun, %w{body faith mind wealth}; end


end
