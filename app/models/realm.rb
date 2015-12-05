class Realm < Indexable

  ########
  LETTERS = %w{S F T N }
  ALL = LETTERS.collect{|letter| self.new letter}
  def path; super.downcase; end
  def self.paths; all.map(&:path); end
  all.each { |r| define_singleton_method(r.path) {all[LETTERS.index r.string]} }
  ########

  def subtypes; Subtype.all.select{|s| s.realm == self}; end
  def +(attitude); subtypes.find{|s| s.attitude == attitude}; end
  Attitude.all.each {|a| define_method(a.path) {self + a}}

  def domain; choose Adjective, %w{gustatory auditory tactile visual}; end
  def name; Phrase.new [domain.titleize, parenthesize]; end

  def sense; choose Verb, %w{taste/smell hear touch see}; end
  def resources; choose Noun, %w{food stories tools truths}; end

  def neuro; choose Noun, %w{serotonin oxytocin dopamine GABA}; end
  def full; choose Adjective, %w{nauseous empathetic frustrated anxious}; end
  def overfull; choose Adjective, %w{sick responsible angry afraid}; end
  def reject; choose Verb, %w{vomit cry fight panic}; end

  def triggers; choose Noun, %w{carbs horror weapons color}; end
  def nontriggers; choose Noun, %w{protein romance walls shapes}; end
  def alt_triggers; choose Noun, %w{sweets tragedy fires contrast}; end
  def alt_nontriggers; choose Noun, %w{fat comedy blankets symmetry}; end

  def putz_verb; choose Verb, %w{take tell manage make}; end
  def putz_nouns; choose Noun, %w{walks stories problems choices}; end
  def putz; Phrase.new([putz_verb, putz_nouns]); end
  def putz_short; choose Verb, %w{walk talk compete choose}; end

  def purge_verb; choose Verb, %w{run make fix make}; end
  def purge_nouns; choose Noun, %w{races speeches problems decisions}; end
  def purge; Phrase.new([purge_verb, purge_nouns]); end
  def purge_short; choose Verb, %w{run lecture win decide}; end

  def big; choose Adjective, %w{long long big complex}; end
  def small; choose Adjective, %w{short short small simple}; end

  def energy; choose Noun, %w{glycogen dependents offense information}; end
  def potentials; choose Noun, %w{fat attachments defence memories}; end
  def empty; choose Adjective, %w{hungry lonely unequipped unsure}; end
  def consume_verb; choose Verb, %w{eat listen use look}; end
  def consume_helper; choose Word, %w{NIL to NIL at}; end
  def consume
    consume_helper ? Phrase.new([consume_verb, consume_helper]) : consume_verb
  end
  def consume_short; choose Verb, %w{eat listen buy look}; end

  def environment; choose Noun, %w{pantry library workshop desk}; end
  def body; choose Noun, %w{belly heart hands head}; end
  def strengths; choose Noun, %w{muscles words procedures mental\ models}; end
  def weak; choose Adjective, %w{sore misunderstood defeated stupid}; end

  def die_verb; choose Verb, %w{starve commit freeze make}; end
  def die_mid; choose Word, %w{to NIL to a\ fatal}; end
  def die_noun; choose Noun, %w{death suicide death mistake}; end
  def die; Phrase.new [die_verb, die_mid, die_noun]; end

end
