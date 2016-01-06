class Realm < Indexable

  ########
  LETTERS = %w{S F T N}
  ALL = LETTERS.collect{|letter| self.new letter}
  all.each { |r| define_singleton_method(r.path) {all[LETTERS.index r.string]} }
  ########

  def subtypes; Subtype.all.select{|s| s.realm == self}; end
  def +(attitude)
    subtypes.find{|s| s.attitude == attitude} || Subtype.new([self, attitude])
  end
  Attitude.all.each {|a| define_method(a.path) {self + a}}

  def neuro; choose Adjective, %w{serotonin oxytocin dopamine GABA}; end

  def domain; choose Adjective, %w{physical spiritual material mental}; end
  def domainly; domain.ly; end
  def name; Phrase.new [domain.titleize, parenthesize]; end

  def consume; choose Verb, %w{eat listen work look}; end
  def consume_with; choose Verb, %w{eat hear earn see}; end

  def produce; choose Verb, %w{walk talk shop think}; end
  def produce_with; choose Verb, %w{do say buy decide}; end

  def unproductive; choose Adjective, %w{lazy silent frugal undecided}; end
  def productive; choose Adjective, %w{active talkative extravagant decisive}; end

  def description; Phrase.new [consume, "and", produce]; end

  def empty; choose Adjective, %w{hungry lonely overdrawn unsure}; end
  def worn_out; choose Adjective, %w{sore misunderstood indebted wrong}; end

  def dying; choose Word, %w{starvation suicide destitution fatal\ mistakes}; end

  def strengths; choose Noun, %w{muscles metaphors credit rules}; end
  def kinetics; choose Noun, %w{glycogen emotions cash facts}; end
  def potential; choose Noun, %w{fat personal\ opinions savings generalizations}; end

  def resources; choose Noun, %w{food stories rewards truths}; end
  def gain_resources; Phrase.new [consume_with, resources]; end

  def strengtheners; choose Noun, %w{protein words repayments results}; end
  def energizers; choose Noun, %w{carbs music wages facts}; end
  def buffers; choose Noun, %w{fat shared\ opinions automatic\ savings categories}; end

  def pv1; choose Verb, %w{go make obtain make}; end
  def pn1; choose Noun, %w{places friends comfort predictions}; end
  def pv2; choose Verb, %w{do influence ensure change}; end
  def pn2; choose Noun, %w{things behavior safety outcomes}; end

  def productions; Phrase.new [pv1, pn1, "and", pv2, pn2]; end

end
