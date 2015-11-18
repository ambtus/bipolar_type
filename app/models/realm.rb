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

  ### produce
  def putz; choose Verb, %w{walk talk shop choose}; end
  def burst_out; choose Verb, %w{run sing splurge decide}; end

  ### consume
  def get; choose Verb, %w{eat hear do see}; end
  def graze_objects; choose Noun, %w{meat lyrics chores outlines}; end
  def binge_objects; choose Noun, %w{potatoes melody projects details}; end
  def graze; Phrase.new [get, graze_objects]; end
  def binge; Phrase.new [get, binge_objects]; end

  ### adjectives
  def fat; choose Adjective, %w{fat emotional rich knowledgeable}; end
  def thin; choose Adjective, %w{thin calm poor ignorant}; end

  ### store kinetic energy as potential energy ###
  def potentials; choose Noun, %w{weight optimism wealth information}; end
  def essentials; choose Noun, %w{fat hope assets concepts}; end
  ### when the essentials run out you will die of ###
  def death; choose Noun, %w{starvation suicide exposure stupidity}; end

end
