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

  def consume_verb; choose Verb, %w{eat listen look work }; end
  def consume_helper; choose Word, %w{NIL to at NIL }; end
  def consume; Phrase.optional consume_verb, consume_helper; end

  def density; [600, 30, 300, 20][index]; end
  def product; density * 4; end
  def kinetics; choose Noun, %w{calories minutes pieces dollars }; end
  def resource; choose Noun, %w{meal story puzzle hour }; end

  def potential; choose Noun, %w{fat friends information savings }; end

  def produce; choose Verb, %w{walk talk decide shop }; end

  def triggers; choose Noun, %w{carbs intonation details rewards }; end
end
