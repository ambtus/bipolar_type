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

  def consume_verb; choose Verb, %w{eat listen use look}; end
  def consume_helper; choose Word, %w{NIL to NIL at}; end
  def consume; consume_helper ? Phrase.new([consume_verb, consume_helper]) : consume_verb; end
  def home; choose Noun, %w{pantry library workshop shelves}; end
  def potentials; choose Noun, %w{fat attachments problems memories}; end
  def body; choose Noun, %w{belly heart hands head}; end
  def strengths; choose Noun, %w{muscles words procedures mental\ models}; end
  def weak; choose Adjective, %w{sore misunderstood defeated stupid}; end

  def triggers; choose Noun, %w{carbs horror weapons color}; end
  def nontriggers; choose Noun, %w{protein romance machines shapes}; end
  def alt_triggers; choose Noun, %w{sweets tragedy sharp\ edges foregrounds}; end
  def alt_nontriggers; choose Noun, %w{savories comedy blunt\ instruments backgrounds}; end

  def putz_verb; choose Verb, %w{walk talk manage choose}; end
  def putz; index == 2 ? Phrase.new([putz_verb, "things"]) : putz_verb; end
  def purge_verb; choose Verb, %w{run scream fix decide}; end
  def purge; index == 2 ? Phrase.new([purge_verb, "things"]) : purge_verb; end
  def something; choose Word, %w{somewhere about\ something something on\ something}; end

  def empty; choose Adjective, %w{hungry lonely unequipped unsure}; end
  def full; choose Adjective, %w{restless emotional frustrated anxious}; end
  def reject; choose Verb, %w{vomit cry fail panic}; end
end
