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

  def adjective; choose Adjective, %w{physical spiritual material mental}; end
  def domain; choose Adjective, %w{gustatory auditory tactile visual}; end
  def name; Phrase.new [domain.titleize, parenthesize]; end

  def sense; choose Verb, %w{taste/smell hear touch see}; end
  def resources; choose Noun, %w{food stories obstacles truths}; end
  def consume_verb; choose Verb, %w{eat listen feel look}; end
  def consume_helper; choose Word, %w{NIL to NIL at}; end
  def consume
    consume_helper ? Phrase.new([consume_verb, consume_helper]) : consume_verb
  end
  def consume_short; choose Verb, %w{eat listen touch look}; end

  def neuro; choose Noun, %w{serotonin oxytocin dopamine GABA}; end
  def full; choose Adjective, %w{nauseous empathetic frustrated anxious}; end
  def overfull; choose Adjective, %w{sick guilty angry afraid}; end
  def reject_verb; choose Verb, %w{throw submit fight panic}; end
def reject_helper; choose Word, %w{up NIL back NIL}; end
def reject
    reject_helper ? Phrase.new([reject_verb, reject_helper]) : reject_verb
  end  

  def energizers; choose Noun, %w{carbs whines pain colors}; end
  def strengtheners; choose Noun, %w{protein words ?? shapes}; end
  def addictions; choose Noun, %w{sweets tragedies weapons details}; end
  def buffers; choose Noun, %w{fat laughter ?? symmetry}; end
  def binge; Phrase.new [consume, addictions]; end
  def energize; Phrase.new [consume, energizers]; end
  def strengthen; Phrase.new [consume, strengtheners]; end
  def graze; Phrase.new [consume, buffers]; end

  def produce_short; choose Verb, %w{move cry play choose}; end 

  def putz_verb; choose Verb, %w{take tell manage make}; end
  def putz_nouns; choose Noun, %w{walks stories effects choices}; end
  def putz; Phrase.new([putz_verb, putz_nouns]); end
  def putz_short; choose Verb, %w{walk talk touch choose}; end

  def purge_verb; choose Verb, %w{run preach root\ out make}; end
  def purge_nouns; choose Noun, %w{races sermons causes decisions}; end
  def purge; Phrase.new([purge_verb, purge_nouns]); end
  def purge_short; choose Verb, %w{run preach win decide}; end

  def big; choose Adjective, %w{long long big complex}; end
  def small; choose Adjective, %w{short short small simple}; end

  def strengths; choose Noun, %w{muscles vocabulary defenses mental\ models}; end
  def energy; choose Noun, %w{glycogen emotions offenses information}; end
  def potentials; choose Noun, %w{fat emotions problems memories}; end
  def empty; choose Adjective, %w{hungry lonely apathetic unsure}; end

  def environment; choose Noun, %w{pantry library workshop desk}; end
  def body; choose Noun, %w{belly heart hands head}; end
  def weak; choose Adjective, %w{sore misunderstood defeated stupid}; end

  def die_verb; choose Verb, %w{starve commit die make}; end
  def die_mid; choose Word, %w{to NIL of a\ fatal}; end
  def die_noun; choose Noun, %w{death suicide exposure mistake}; end
  def die; Phrase.new [die_verb, die_mid, die_noun]; end

end
