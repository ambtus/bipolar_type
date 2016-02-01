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

  def consume; choose Verb, %w{eat hear see earn }; end
  def energizers; choose Noun, %w{carbs intonation facts wages }; end
  def strengtheners; choose Noun, %w{protein words results salary }; end

  def consume_energizers; Phrase.new [consume, energizers]; end
  def consume_strengtheners; Phrase.new [consume, strengtheners]; end

  def pev; choose Verb, %w{go express make spend }; end
  def pen; choose Noun, %w{places emotions choices cash }; end
  def produce_energetically; Phrase.new [pev, pen]; end

  def psv; choose Verb, %w{lift influence prevent use }; end
  def psn; choose Noun, %w{weights people problems credit }; end
  def produce_strongly; Phrase.new [psv, psn]; end

  def strengths; choose Noun, %w{muscles metaphors rules credit }; end
  def energy; choose Noun, %w{fat opinions knowledge savings }; end

end
