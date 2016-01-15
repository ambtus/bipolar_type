class Realm < Indexable

  def domain; choose Adjective, %w{physical social mental financial}; end
  ########
  LETTERS = %w{p s m f}
  ALL = LETTERS.collect{|letter| self.new letter}
  all.each { |r| define_singleton_method(r.path) {all[LETTERS.index r.string]} }
  ########

  def subtypes; Subtype.all.select{|s| s.realm == self}; end
  def +(attitude)
    subtypes.find{|s| s.attitude == attitude} || Subtype.new([self, attitude])
  end
  Attitude.all.each {|a| define_method(a.path) {self + a}}

  def neuro; choose Adjective, %w{serotonin oxytocin GABA dopamine}; end

  def domain; choose Adjective, %w{physical social mental financial}; end
  def domainly; domain.ly; end
  def name; domain.titleize; end

  def consume; choose Verb, %w{eat listen look earn }; end
  def consume_suffix; choose Word, %w{NIL to at NIL }; end
  def consume_with; Phrase.optional consume, consume_suffix; end

  def produce; choose Verb, %w{walk talk reason play }; end
  def produce_with; choose Verb, %w{do say predict buy }; end

  def unproductive; choose Adjective, %w{lazy silent undecided frugal }; end
  def productive; choose Adjective, %w{active talkative decisive extravagant }; end

  def empty; choose Adjective, %w{hungry lonely unsure miserly }; end
  def full; choose Adjective, %w{satisfied connected convinced rewarded }; end
  def ready; choose Adjective, %w{restless excited confident rich }; end
  def worn_out; choose Adjective, %w{sore misunderstood wrong indebted }; end

  def dying; choose Word, %w{starvation suicide  fatal\ mistakes destitution}; end

  def strengths; choose Noun, %w{muscles metaphors rules credit }; end
  def atrophy; strengths.uncountable? ? "atrophies" : "atrophy"; end
  def strengths_atrophy; Phrase.new [strengths, atrophy]; end
  def kinetics; choose Noun, %w{glycogen emotions facts cash }; end
  def potential; choose Noun, %w{fat friends memories savings }; end
  def energy; Phrase.new [kinetics, "and", potential]; end

  def externals; choose Noun, %w{food stories truths rewards }; end
  def gain_internals; Phrase.new [consume_with, externals]; end
  def internals; choose Noun, %w{body opinions knowledge wealth }; end

  def strengtheners; choose Noun, %w{protein words patterns loan\ repayments }; end
  def triggers; choose Noun, %w{carbs voices facts income }; end
  def buffers; choose Noun, %w{fat harmony categories automatic\ investments }; end

  def consume_triggers; Phrase.new [consume_with, triggers]; end
  def consume_strengtheners; Phrase.new [consume_with, strengtheners]; end

  def pve; choose Verb, %w{do express make spend }; end
  def pae; choose Adjective, %w{aerobic strong simple petty}; end
  def pne; choose Noun, %w{exercise emotions choices cash }; end
  def produce_energetically; Phrase.new [pve, pae, pne]; end
  def pvs; choose Verb, %w{lift verbalize make use }; end
  def pas; choose Adjective, %w{heavy abstract complex available}; end
  def pns; choose Noun, %w{weights concepts decisions credit }; end
  def produce_strongly; Phrase.new [pvs, pas, pns]; end

end
