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
  def neuro; choose Noun, %w{serotonin oxytocin dopamine norepinephrine}; end

  def sense; choose Verb, %w{taste hear finish see}; end

  def organs; choose Noun, %w{stomach heart hands head}; end
  def organs_clench; organs.if_uncountable_suffix("clenches", "clench"); end
  def organs_ache; organs.if_uncountable_suffix("aches", "ache"); end

  # the four basic behaviors
  def putz; choose Verb, %w{walk talk shop analyze}; end # tired. uses a few kinetics
  def purge; choose Verb, %w{run yell splurge synthesize}; end # energetic. uses a lot of kinetics. 
  def graze(insert=nil); Phrase.new [get, get_helper, insert, nony, nons]; end
  def binge(insert=nil); Phrase.new [get, get_helper, insert, triggery, triggers]; end

  def get_triggered(insert=nil)
    Phrase.new [get, get_helper, insert, triggery, resources]
  end

  # the bigger your strengths, the more kinetics they can soak up
  def strengths; choose Noun, %w{muscles vocabulary credit logic}; end
  def singular_strengths; choose Noun, %w{muscles words loans rules}; end
  def kinetics; choose Noun, %w{glycogen enemies cash facts}; end
  # you need strengths and kinetic energy in order to produce
  def things; choose Noun, %w{places things tools solutions}; end
  def produce; choose Verb, %w{go say buy identify}; end
  def it; choose Noun, %w{there it it it}; end
  def thing; choose Noun, %w{where thing thing thing}; end
  def much; choose Adjective, %w{far much much much}; end
  def start; choose Verb, %w{get speak pony hurry}; end
  def small; choose Adjective, %w{nearby trite cheap easy}; end
  def easily; choose Word, %w{slowly quietly for\ necessities the\ obvious}; end
  # if you don't have enough strengths you will be
  def sore; choose Adjective, %w{sore misunderstood indebted wrong}; end
  def unproductive; choose Adjective, %w{seated silent miserly undecided}; end

  def produce_something; Phrase.new [produce, thing.some]; end

  # you get them by taking a break (usually during defined periods)
  def period; choose Noun, %w{meal story work class}; end
  def time; period.time; end

  def get; choose Verb, %w{eat listen do look}; end
  def get_helper; choose Verb, %w{NIL to NIL at}; end
  def consume; choose Verb, %w{eat hear do see}; end
  def get_without; choose Verb, %w{eat listen work look}; end

  def triggers; choose Noun, %w{snacks whines projects details}; end
  def triggery; choose Adjective, %w{high-carb dissonant risky colorful}; end
  def nons; choose Noun, %w{meals words chores outlines}; end
  def nony; choose Adjective, %w{high-protein lyrical predictable black-and-white}; end
  def resources; choose Noun, %w{food voices jobs information}; end

  # and you stop consuming resources either because you're full
  def full; choose Adjective, %w{satisfied sympathetic frustrated anxious}; end
  # which is a sign you can purge

  # or because you are overwhelmed
  def overwhelmed; choose Adjective, %w{sick responsible angry afraid}; end
  # which is a sign that you're about to reject the triggers (and nons)
  def reject
    if index == 0
      Phrase.new [Verb.new("throw"), "up"]
    else
      choose Verb, %w{NIL cry quit panic}
    end
  end
  def turn_up_the_signal
    case string
    when "N"
      "turn on the lights"
    when "S"
      "add some sugar"
    when "T"
      "?? ??"
    when "F"
      "turn up the volume"
    end.to_phrase
  end

  # kinetic energy is converted to and from potential energy
  def potentials; choose Noun, %w{fat friends savings memories}; end

  # you don't need potentials if the resources are abundant and tolerable
  def tolerate; choose Verb, %w{stomach accept handle believe}; end

  # but you must have essentials
  def critical; choose Adjective, %w{essential attachments retirement true}; end
  def stores; choose Noun, %w{fat objects savings beliefs}; end
  def essentials; Phrase.new [critical, stores]; end

  # running out of kinetics and tapping into potentials
  def empty; choose Adjective, %w{hungry loved purse-pinched calm}; end

  # running out of kinetics and tapping into essentials
  def dying; choose Adjective, %w{starving suicidal destitute clueless}; end
  alias_method :deathly, :dying

  def die_verb; choose Verb, %w{starve commit go make}; end
  def die_mid; choose Word, %w{to NIL NIL a\ fatal}; end
  def die_noun; choose Noun, %w{death suicide bankrupt mistake}; end
  def die; Phrase.new [die_verb, die_mid, die_noun]; end
end
