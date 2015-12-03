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

  def domain; choose Adjective, %w{physical social financial mental}; end
  def name; Phrase.new [domain.titleize, parenthesize]; end

  def sense; choose Verb, %w{taste/smell hear touch see}; end
  def neuro; choose Noun, %w{serotonin oxytocin dopamine GABA}; end

  def consume_verb; choose Verb, %w{eat listen do look}; end
  def consume_helper; choose Word, %w{NIL to NIL at}; end
  def consume; consume_helper ? Phrase.new([consume_verb, consume_helper]) : consume_verb; end
  def resources; choose Noun, %w{foods stories tasks information}; end
  def home; choose Noun, %w{pantry library office files}; end
  def potentials; choose Noun, %w{fat attachments cash memories}; end
  def body; choose Noun, %w{fat\ cells heart purse mind}; end
  def strengths; choose Noun, %w{muscles ?? credit models}; end

  def triggers; choose Noun, %w{carbs horror projects color}; end
  def nontriggers; choose Noun, %w{protein romance chores shapes}; end
  def alt_triggers; choose Noun, %w{sweets tragedy short\ term\ goals facts}; end
  def alt_nontriggers; choose Noun, %w{savories comedy long\ term\ goals patterns}; end

  def putz; choose Verb, %w{walk talk work choose}; end
  def purge; choose Verb, %w{run scream play decide}; end

  def empty; choose Adjective, %w{hungry lonely frustrated anxious}; end
  def full; choose Adjective, %w{restless emotional pleased sure}; end
end
