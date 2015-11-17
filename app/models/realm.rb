class Realm < Indexable

  ########
  LETTERS = %w{S F T N }
  ALL = LETTERS.collect{|letter| self.new letter}
  def path; string.downcase; end
  def self.paths; all.map(&:path); end
  all.each do |realm|
    define_singleton_method(realm.path) {all[LETTERS.index realm.string]}
  end
  ########

  def subtypes; Subtype.all.select{|s| s.realm == self}; end

  def domain; choose Adjective, %w{physical spiritual financial mental}; end
  def name; Phrase.new [domain.capitalize, parenthetical]; end

  ### consume resources to acquire energy, use energy to produce ###
  def consume; choose Verb, %w{eat listen work look}; end
  def resource; choose Noun, %w{meal voice job piece}; end
  def kinetics; choose Noun, %w{glycogen motivation tools connections}; end
  def produce; choose Verb, %w{move talk grab synthesize}; end

  ##### stop producing and start consuming ######

  ### eX: external breaks ###
  def seem; choose Verb, %w{smell sound feel look}; end
  def compelling; choose Adjective, %w{appetizing whiney smooth colorful}; end
  def red_light; choose Noun, %w{appetite intonation texture color}; end

  ### iX: internal breaks ###
  def empty; choose Adjective, %w{hungry hopeless indebted worried}; end
  def emptiness; choose Noun, %w{hunger hopelessness debt anxiety}; end

  ##### stop consuming and start producing ######

  ### Xj: external accelerator ###
  def neuro; choose Noun, %w{serotonin oxytocin dopamine GABA}; end
  def filling; choose Adjective, %w{satisfying musical rewarding connected}; end
  def triggers; choose Noun, %w{carbs music rewards details}; end
  # non-triggers
  def strengths; choose Noun, %w{protein words investments patterns}; end

  ### Xp: internal accelerator ###
  def full; choose Adjective, %w{restless loved rewarded convinced}; end

  ### store kinetic energy as potential energy ###
  def potentials; choose Noun, %w{weight optimism wealth information}; end
  def essentials; choose Noun, %w{fat hope assets knowledge}; end

  ### or when the resources run out you will die of ###
  def death; choose Noun, %w{starvation suicide exposure stupidity}; end

  ### adjectives
  def fat; choose Adjective, %w{fat social moneyed educated}; end
  def thin; choose Adjective, %w{thin independent cash-poor uneducated}; end
  def energetic; choose Adjective, %w{energetic emotional cluttered clever}; end
  def strong; choose Adjective, %w{strong eloquent asset-rich smart}; end

end
