class Realm < Indexable

  ########
  IDENTIFIERS = %w{physical social mental financial}
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

  def consume; choose Verb, %w{eat listen look earn }; end
  def consume_suffix; choose Word, %w{NIL to at NIL }; end
  def consume_with; Phrase.optional consume, consume_suffix; end

  def empty; choose Adjective, %w{hungry lonely unsure miserly }; end
  def full; choose Adjective, %w{satisfied empathetic convinced rewarded }; end
  def ready; choose Adjective, %w{restless excited confident rich }; end
  def worn_out; choose Adjective, %w{sore misunderstood wrong indebted }; end

  def dying; choose Word, %w{starvation suicide  fatal\ mistakes destitution}; end

  def strengths_adj; choose Adjective, %w{strong abstract logical strong }; end
  def strengths_noun; choose Noun, %w{muscles metaphors rules credit }; end
  # def strengths; Phrase.new [strengths_adj, strengths_noun]; end
  def strengths; strengths_noun; end
  def atrophy; strengths_noun.uncountable? ? "atrophies" : "atrophy"; end
  def accumulate; strengths_noun.uncountable? ? "accumulates" : "accumulate"; end
  def strengths_atrophy; Phrase.new [strengths, atrophy]; end
  def strengths_accumulate; Phrase.new [strengths, accumulate]; end
  def kinetics; choose Noun, %w{glycogen emotions facts cash }; end
  def potential; choose Noun, %w{fat friends knowledge savings }; end
  def atrophies; potential.uncountable? ? "atrophies" : "atrophy"; end
  def accumulates; potential.uncountable? ? "accumulates" : "accumulate"; end
  def potential_atrophies; Phrase.new [potential, atrophies]; end
  def potential_accumulates; Phrase.new [potential, accumulates]; end

  def energy; Phrase.new [kinetics, "and", potential]; end

  def externals; choose Noun, %w{food stories truths rewards }; end
  def gain_internals; Phrase.new [consume_with, externals]; end
  def internals; Phrase.new [strengths, "and", potential]; end

  def external_storage; choose Noun, %w{pantry network references pay\ checks }; end

  def strengtheners; choose Noun, %w{protein words results repayments }; end
  def trigger_adjective; choose Adjective, %w{sweet whiny colorful disposable }; end
  def energizers; choose Noun, %w{carbs intonation details spending\ money }; end
  def buffers; choose Noun, %w{fat humor categories automatic\ investments }; end

  def consume_energizers; Phrase.new [consume_with, energizers ]; end
  def consume_strengtheners; Phrase.new [consume_with, strengtheners]; end

  def consume_more_energizers; Phrase.new [consume_with, "more", energizers ]; end
  def consume_more_strengtheners; Phrase.new [consume_with, "more", strengtheners]; end

  def pve; choose Verb, %w{go express solve spend }; end
  def pae; choose Adjective, %w{distant strong current hard}; end
  def pne; choose Noun, %w{places emotions problems cash }; end
  def produce_energetically; Phrase.new [pve, pae, pne]; end
  def produce_more_energetically; Phrase.new [pve, pae.er, pne]; end

  def pvs; choose Verb, %w{lift verbalize prevent borrow }; end
  def pas; choose Adjective, %w{heavy abstract future secured }; end
  def pns; choose Noun, %w{weights concepts problems money }; end
  def produce_strongly; Phrase.new [pvs, pas, pns]; end
  def produce_more_strongly; Phrase.new [pvs, pas.er, pns]; end


  def produce; Phrase.new [pve, pae, pne, "and", pvs, pas, pns]; end

  def productions; choose Noun, %w{exercise conversations situations purchases }; end

  def unproductive; choose Adjective, %w{lazy silent undecided frugal }; end
  def productive; choose Adjective, %w{active talkative decisive extravagant }; end
end
