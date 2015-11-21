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

  def domain; choose Adjective, %w{physical emotional financial mental}; end
  def name; Phrase.new [domain.capitalize, parenthesize]; end
  def neuro; choose Noun, %w{serotonin oxytocin dopamine norepinephrine}; end
  def triggered; choose Adjective, %w{satisfied empathetic successful bored}; end
  def mania; Phrase.new [neuro, "overload"]; end

  def behaviors; [binge, futz, burst, graze]; end

  def futz; choose Verb, %w{walk talk shop choose}; end
  def burst; choose Verb, %w{run cry splurge decide}; end
  def graze; Phrase.new [get, nontriggers]; end
  def binge; Phrase.new [get, triggers]; end


  def get; choose Verb, %w{eat hear do see}; end
  def get_without_object; choose Verb, %w{eat listen work learn}; end

  def tolerate; choose Noun, %w{stomach understand reach believe}; end
  def resources; choose Noun, %w{foods stories jobs facts}; end

  def nontriggers; choose Noun, %w{protein words chores patterns}; end
  def triggers; choose Noun, %w{carbs emotions projects details}; end
  def seem; choose Verb, %w{taste sound feel look}; end

  def build
    nontriggers.if_uncountable("builds and repairs", "build and repair")
  end
  def strengths; choose Noun, %w{muscles vocabulary credit concepts}; end

  def kinetics; choose Noun, %w{glycogen empathy cash short-term-memories}; end
  def potentials; choose Noun, %w{fat attachments savings long-term-memories}; end
  def essentials
    choose Phrase,
    ["essential fat stores",
     "reasons for living",
     "retirement assets",
     "critical facts"].map(&:split)
  end

  def uncomfortable; choose Adjective, %w{hungry lonely purse-pinched wrong}; end
  def dying; choose Adjective, %w{starving suicidal going\ bankrupt forgetful}; end
  def death; choose Noun, %w{starvation suicide bankruptcy ignorance}; end

end
