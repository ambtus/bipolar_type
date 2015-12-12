class Realm < Indexable

  ########
  LETTERS = %w{S F T N }
  ALL = LETTERS.collect{|letter| self.new letter}
  all.each { |r| define_singleton_method(r.path) {all[LETTERS.index r.string]} }
  ########

  def subtypes; Subtype.all.select{|s| s.realm == self}; end
  def +(attitude); subtypes.find{|s| s.attitude == attitude}; end
  Attitude.all.each {|a| define_method(a.path) {self + a}}

  def domain; choose Adjective, %w{gustatory auditory tactile visual}; end
  def name; Phrase.new [domain.titleize, parenthesize]; end
  def sense; choose Noun, %w{taste/smell hearing touch/pain sight}; end
  def neuro; choose Noun, %w{serotonin oxytocin dopamine GABA}; end
  def consume; choose Verb, %w{eat listen work look}; end
  def produce; choose Verb, %w{move communicate play predict}; end
  def kinetics; choose Noun, %w{glycogen friends cash information}; end
  def potentials; choose Noun, %w{fat family savings memories}; end

  def reject_verb; choose Verb, %w{throw cry break notice}; end
  def reject_with; choose Word, %w{up NIL things exceptions}; end
  def reject; reject_with ? Phrase.new([reject_verb, reject_with]) : reject_verb; end
  def provide; choose Verb, %w{cook tell build create}; end
  def resources; choose Noun, %w{meals stories tools explanations}; end

  def adjective; choose Adjective, %w{physical spiritual material mental}; end
end
