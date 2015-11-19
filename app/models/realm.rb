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

  def domain; choose Adjective, %w{physical spiritual financial mental}; end
  def name; Phrase.new [domain.capitalize, parenthesize]; end
  def neuro; choose Noun, %w{serotonin oxytocin dopamine norepinephrine}; end
  def triggered; choose Adjective, %w{satisfied empathetic successful bored}; end
  def mania; Phrase.new [neuro, "overload"]; end

  ### the four behaviors
  def putz; choose Verb, %w{walk talk shop choose}; end
  def burst; choose Verb, %w{run cry splurge decide}; end
  def graze; Phrase.new [get, graze_examples]; end
  def binge; Phrase.new [get, binge_examples]; end

  def get; choose Verb, %w{eat hear achieve see}; end
  def get_without_object; choose Verb, %w{eat listen work learn}; end

  def tolerate; choose Noun, %w{stomach understand reach believe}; end
  def resources; choose Noun, %w{meals stories goals information}; end

  def graze_examples; choose Noun, %w{savories lyrics chores generalities}; end
  def binge_examples; choose Noun, %w{sweets music projects specifics}; end

  def graze_objects
    choose Noun, %w{protein words manageable-problems patterns}
  end
  def binge_objects
    choose Noun, %w{carbs tone\ of\ voice solvable-problems details}
  end
  def seem; choose Verb, %w{taste sound feel look}; end

  ### use graze_objects to build strengths ###
  def build
    graze_objects.if_uncountable("builds and repairs", "build and repair")
  end
  def strengths; choose Noun, %w{muscles vocabulary credit concepts}; end

  ### store binge_objects as potential energy ###
  def potentials; choose Noun, %w{fat faith savings memories}; end
  ### when essential potentials run out you will die of ###
  def death; choose Noun, %w{starvation suicide exposure ignorance}; end
  def deathly; choose Noun, %w{starving suicidal indebted forgetful}; end

end
