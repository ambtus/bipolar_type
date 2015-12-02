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

  def domain; choose Adjective, %w{physical verbal financial mental}; end
  def name; Phrase.new [domain.titleize, parenthesize]; end

  def senses; choose Noun, %w{taste/smell hearing touch/pain sight}; end
  def neuro; choose Noun, %w{serotonin oxytocin dopamine GABA}; end

  # Mania. oversensitivity.
  # That seems so triggery, how can you consume it? at least add some buffers!
  def seem; choose Verb, %w{taste sound feel look}; end
  def triggery; choose Adjective, %w{sweet loud dangerous bright}; end
  def consume_verb; choose Verb, %w{eat listen touch look}; end
  def buffers; choose Noun, %w{fat harmony protection outlines}; end

  def consume_helper; choose Verb, %w{NIL to NIL at}; end
  def consume
    consume_helper ? Phrase.new([consume_verb, consume_helper]) : consume_verb
  end

  def triggers; choose Noun, %w{carbs whines toys lights}; end
  def trigger_phrase; Phrase.new [triggery, triggers]; end

  # Depression. a lack of energy
  # I can't reach a climax, I keep loosing my kinetics. I have hit the wall.
  # I am depressed, but all I need is some energy...
  def climax; choose Noun, %w{destination agreement goal conclusion}; end
  def lose; chose Verb, %w{deplete change drop forget}; end
  def kinetics; choose Noun, %w{glycogen opinion tools facts}; end

  # Weakness, where you have plenty of energy but not enough strength
  # I can't reach a climax, my strengths are weak.
  # I am weak, and it will take time to build strengths...
  def strengths; choose Noun, %w{muscles vocabulary credit mental-models}; end

  def nontrigger_phrase; Phrase.new [nontriggery, nontriggers]; end

  def nontriggery; choose Adjective, %w{savory lyrical safe black-and-white}; end
  def nontriggers; choose Noun, %w{protein words utensil outlines}; end

  # generic resources, may be triggery or nontriggery
  def resources; choose Noun, %w{food stories things sights}; end

  # consumption which builds strengths but provides relatively few kinetics
  def graze(insert=nil); Phrase.new [consume, insert, nontriggery, nontriggers]; end
  # consumption which provides lots of kinetics but does not build strengths
  def binge(insert=nil); Phrase.new [consume, insert, triggery, triggers]; end

  # production which uses relatively few kinetics
  def putz; choose Verb, %w{walk talk compete choose}; end
  # production which typically uses more kinetics, and also a fair amount of strengths
  def putz; choose Verb, %w{run write win decide}; end

  # before you can reach a climax you have to: start up and produce something
  def start_up; Phrase.new [start, "up"]; end
  def produce_things; Phrase.new [produce, things]; end
  def produce_something; Phrase.new [produce, thing.some]; end

  def start; choose Verb, %w{get speak ante hurry}; end
  def produce; choose Verb, %w{go influence pursue solve}; end
  def thing; choose Noun, %w{where one thing thing}; end # with some, any, no, every

  def things; choose Noun, %w{places people pleasures problems}; end
  def it; choose Noun, %w{there them it it}; end

  # if you don't have enough strengths you will be strained
  def strained; choose Adjective, %w{sore misunderstood uncomfortable mistaken}; end
  # you have the right to remain unproductive if you don't want to produce 
  def unproductive; choose Adjective, %w{seated silent neglectful undecided}; end
  
  # you consume resources by taking a break (usually during defined periods)
  def period; choose Noun, %w{meal story work/play class}; end
  def time; period.time; end

  # you stop consuming resources either because you're full
  def full; choose Adjective, %w{satisfied empathetic frustrated anxious}; end

  # or because you are overwhelmed
  def overwhelmed; choose Adjective, %w{sick responsible angry afraid}; end
  # which is a sign that you're about to reject the triggers (and nontriggers)
  def reject
    if index == 0
      Phrase.new [Verb.new("throw"), "up"]
    else
      choose Verb, %w{NIL cry quit panic}
    end
  end

  # kinetic energy is converted to and from potential energy
  def potentials; choose Noun, %w{fat prejudices money memories}; end

  # you don't need potentials if the resources are abundant and you can tolerate them
  def tolerate; choose Verb, %w{stomach accept handle believe}; end

  # but you must have essentials
  def critical; choose Adjective, %w{essential attachments retirement true}; end
  def stores; choose Noun, %w{fat objects savings beliefs}; end
  def essentials; Phrase.new [critical, stores]; end

  # running out of kinetics and tapping into potentials
  def empty; choose Adjective, %w{hungry disliked poor unsure}; end

  # running out of kinetics and tapping into essentials
  def dying; choose Adjective, %w{starving suicidal destitute clueless}; end
  alias_method :deathly, :dying

  def die_verb; choose Verb, %w{starve commit go make}; end
  def die_mid; choose Word, %w{to NIL NIL a\ fatal}; end
  def die_noun; choose Noun, %w{death suicide bankrupt mistake}; end
  def die; Phrase.new [die_verb, die_mid, die_noun]; end
end
