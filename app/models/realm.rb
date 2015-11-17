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

  ### stop at the gas station and consume to get kinetics ###
  def gas_station; choose Noun, %w{meal story play class}; end
  def consume; choose Verb, %w{eat listen fight watch}; end
  def kinetics; choose Noun, %w{glycogen motivation rewards facts}; end

  ### use kinetics to produce on the road ###
  def produce; choose Verb, %w{move talk compete decide}; end
  def road; choose Noun, %w{play question competition test}; end

  ##### stop producing and start consuming ######

  ### eX: external breaks ###
  def seem; choose Verb, %w{smell sound feel look}; end
  def compelling; choose Adjective, %w{appetizing whiney sharp colorful}; end
  def red_light; choose Noun, %w{appetite intonation texture color}; end

  ### iX: internal breaks ###
  def empty; choose Adjective, %w{hungry lonely frustrated anxious}; end
  def emptiness; choose Noun, %w{hunger loneliness anger fear}; end

  ##### stop consuming and start producing ######

  ### Xj: external accelerator ###
  def neuro; choose Noun, %w{serotonin oxytocin dopamine GABA}; end
  def triggered; choose Adjective, %w{satisfied responsible successful convinced}; end
  def get; choose Verb, %w{eat hear fight see}; end
  def triggers; choose Noun, %w{carbs whines battles details}; end

  def non_triggers; choose Noun, %w{protein words wars connections}; end
  def strengths; choose Noun, %w{muscles vocabulary assets mental-models}; end

  ### Xp: internal accelerator ###
  def full; choose Adjective, %w{restless loved competent sure}; end

  ### store kinetic energy as potential energy ###
  def potentials; choose Noun, %w{weight optimism wealth information}; end
  def essentials; choose Noun, %w{fat hope assets knowledge}; end

  ### or when the essentials run out you will die of ###
  def death; choose Noun, %w{starvation suicide exposure stupidity}; end

  ### adjectives
  def fat; choose Adjective, %w{fat popular rich trivial}; end
  def thin; choose Adjective, %w{thin alone poor ignorant}; end

end
