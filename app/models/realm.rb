class Realm < Indexable

  ########
  LETTERS = %w{SF NF ST NT }
  ALL = LETTERS.collect{|letter| self.new letter}
  all.each { |r| define_singleton_method(r.path) {all[LETTERS.index r.string]} }
  ########

  def subtypes; Subtype.all.select{|s| s.realm == self}; end
  def +(attitude); subtypes.find{|s| s.attitude == attitude}; end
  Attitude.all.each {|a| define_method(a.path) {self + a}}

  def adjective; choose Adjective, %w{physical spiritual material mental}; end
  def domain; choose Adjective, %w{gustatory auditory tactile visual}; end
  def name; Phrase.new [domain.titleize, parenthesize]; end

  def neuro; choose Noun, %w{serotonin oxytocin dopamine GABA}; end
  def full; choose Adjective, %w{satisfied empathetic finished bored}; end
  def feel_full; Phrase.new ["feel", full]; end
  def overfull; choose Adjective, %w{sick guilty angry afraid}; end
  def reject_verb; choose Verb, %w{throw cry destroy panic}; end
  def reject_helper; choose Word, %w{up NIL something NIL}; end
  def reject
    reject_helper ? Phrase.new([reject_verb, reject_helper]) : reject_verb
  end

  def sense; choose Verb, %w{taste/smell hear touch see}; end
  def resources; choose Noun, %w{food stories tools truths}; end
  def consume_with; choose Verb, %w{eat hear use see}; end
  def consume; choose Verb, %w{eat listen earn look}; end
  def provide; choose Verb, %w{feed tell pay show}; end

  def triggers; choose Noun, %w{carbs tragedy obstacles colors}; end
  def strengtheners; choose Noun, %w{protein happy\ endings detours shapes}; end
  def buffers; choose Noun, %w{fat comedy tools symmetry}; end
  def binge; Phrase.new [consume_with, triggers]; end
  def graze; Phrase.new [consume_with, strengtheners]; end

  def produce; choose Verb, %w{move communicate spend think}; end
  def putz; choose Verb, %w{walk talk shop specify}; end
  def purge; choose Verb, %w{run shout splurge generalize}; end

  def strengths; choose Noun, %w{muscles vocabulary defenses mental\ models}; end
  def kinetics; choose Noun, %w{glycogen emotions rewards information}; end
  def potentials; choose Noun, %w{fat friends savings memories}; end
  def empty; choose Adjective, %w{hungry lonely apathetic unsure}; end

  def environment; choose Noun, %w{pantry library workshop desk}; end
  def body; choose Noun, %w{belly heart hands head}; end
  def weak; choose Adjective, %w{sore misunderstood defeated stupid}; end

  def die_verb; choose Verb, %w{starve commit die make}; end
  def die_mid; choose Word, %w{to NIL of a\ fatal}; end
  def die_noun; choose Noun, %w{death suicide exposure mistake}; end
  def die; Phrase.new [die_verb, die_mid, die_noun]; end

end
