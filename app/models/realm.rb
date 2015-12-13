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
  def consume_helper; choose Word, %w{NIL to NIL at}; end
  def consume_with; consume_helper ? Phrase.new([consume, consume_helper]) : consume; end
  def process; choose Verb, %w{digest wait\ for ?? believe}; end
  def produce; choose Verb, %w{walk talk shop predict}; end
  def kinetics; choose Noun, %w{glucose hate cash information}; end
  def potentials; choose Noun, %w{fat prejudice savings opinion}; end

  def reject_verb; choose Verb, %w{throw cry splurge criticize}; end
  def reject_with; choose Word, %w{up NIL NIL NIL}; end
  def reject; reject_with ? Phrase.new([reject_verb, reject_with]) : reject_verb; end

  def provide_verb; choose Verb, %w{cook write provide provide}; end
  def resources; choose Noun, %w{meals stories solutions explanations}; end
  def triggery; choose Noun, %w{sweet cruel undeserved illogical}; end
  def ending; choose Noun, %w{dessert ending reward conclusion}; end
  def triggers; Phrase.new [triggery, ending.pluralize]; end
  def provide; choose Verb, %w{cook moralize persevere reason}; end

  def adjective; choose Adjective, %w{physical spiritual material mental}; end
  def adverb; adjective.ly; end
  def provision; choose Verb, %w{feed lecture employ show}; end
  def empty; choose Adjective, %w{hungry ostracized uncomfortable curious}; end
  def even_emptier; choose Adjective, %w{starving suicidal destitute wrong}; end
  def time; (choose Noun, %w{meal story work class}).time; end
  def ingredients; choose Noun, %w{foods friends tools references}; end
  def place; choose Noun, %w{pantry network workbench desk}; end
end
