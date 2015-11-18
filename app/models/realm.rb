class Realm < Indexable

  ########
  LETTERS = %w{S F T N }
  ALL = LETTERS.collect{|letter| self.new letter}
  def path; super.downcase; end
  def self.paths; all.map(&:path); end
  all.each do |realm|
    define_singleton_method(realm.path) {all[LETTERS.index realm.string]}
  end
  ########

  def subtypes; Subtype.all.select{|s| s.realm == self}; end

  def domain; choose Adjective, %w{physical spiritual material mental}; end
  def name; Phrase.new [domain.capitalize, parenthetical]; end

  ### behaviors
  def consume; choose Verb, %w{eat listen earn learn}; end
  def produce; choose Verb, %w{walk talk spend decide}; end

  def get; choose Verb, %w{eat hear earn see}; end
  def triggers; choose Noun, %w{carbs whines wages details}; end
  def non_triggers; choose Noun, %w{protein words interest connections}; end

  ### adjectives
  def fat; choose Adjective, %w{fat pestered cluttered pedantic}; end
  def thin; choose Adjective, %w{skinny alone poor ignorant}; end
  def restless; choose Adjective, %w{restless emotional greedy arrogant}; end
  def sore; choose Adjective, %w{sore misunderstood indebted wrong}; end

  ### store kinetic energy as potential energy ###
  def potentials; choose Noun, %w{weight optimism wealth information}; end
  def essentials; choose Noun, %w{fat hope assets concepts}; end
  ### when the essentials run out you will die of ###
  def death; choose Noun, %w{starvation suicide exposure stupidity}; end

end
