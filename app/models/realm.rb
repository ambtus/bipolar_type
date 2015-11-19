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

  def get; choose Verb, %w{eat hear do see}; end
  def get_without_object; choose Verb, %w{eat listen work learn}; end

  def tolerate; choose Noun, %w{stomach understand reach believe}; end
  def resources; choose Noun, %w{foods stories jobs facts}; end

  def graze_examples; choose Noun, %w{savories lyrics chores rules}; end
  def binge_examples; choose Noun, %w{sweets music projects exceptions}; end

  def graze_objects
    choose Noun, %w{protein words salary patterns}
  end
  def binge_objects; choose Noun, %w{carbs emotions bonuses details}; end
  def seem; choose Verb, %w{taste sound feel look}; end

  ### use graze_objects to build strengths ###
  def build
    graze_objects.if_uncountable("builds and repairs", "build and repair")
  end
  def strengths; choose Noun, %w{muscles vocabulary credit concepts}; end

  def kinetics; choose Noun, %w{glycogen empathy cash short-term-memories}; end
  ### store unused kinetics as potential energy ###
  def potentials; choose Noun, %w{fat faith savings memories}; end
  def essentials
    choose Phrase,
    ["essential fat stores", 
     "faith in the essential goodness of (at least some) people", 
     "savings (at least in your mind)", 
     "long term memories"].map(&:split)
  end
  ### when essential potentials run out you will die of ###
  def death; choose Noun, %w{starvation suicide bankruptcy ignorance}; end
  def deathly; choose Adjective, %w{starving suicidal bankrupt forgetful}; end
  def uncomfortable; choose Adjective, %w{hungry lonely indebted unsure}; end

end
