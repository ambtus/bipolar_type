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

  def domain; choose Adjective, %w{physical spiritual material mental}; end
  def name; Phrase.new [domain.titleize, parenthesize]; end
  def neuro; choose Noun, %w{serotonin oxytocin dopamine GABA}; end

  # the four basic behaviors
  def putz; choose Verb, %w{walk talk shop believe}; end # nurture
  def splurge; choose Verb, %w{run yell buy verify}; end # nature
  def graze(insert=nony); Phrase.new [get, get_helper, insert, nons]; end
  def binge(insert=triggery); Phrase.new [get, get_helper, insert, triggers]; end

  def get_triggered(insert=nil)
    Phrase.new [get, get_helper, insert, triggery, resources]
  end

  # the bigger your strengths, the more kinetics they can soak up
  def strengths; choose Noun, %w{muscles lexicon investments mental-models}; end
  def kinetics; choose Noun, %w{glycogen emotions cash information}; end
  # you need strengths and kinetic energy in order to produce
  def produce; choose Verb, %w{move comfort spend decide}; end

  # you get them by taking a break (usually during defined periods)
  def period; choose Noun, %w{meal story work class}; end
  def time; period.time; end

  def get; choose Verb, %w{eat listen do look}; end
  def get_helper; choose Verb, %w{NIL to NIL at}; end
  def get_with; choose Verb, %w{eat hear do see}; end
  def get_without; choose Verb, %w{eat listen work look}; end

  def triggers; choose Noun, %w{desserts complaints projects details}; end
  def triggery; choose Adjective, %w{high-carb whiney short-term colorful}; end
  def nons; choose Noun, %w{meals words chores outlines}; end
  def nony; choose Adjective, %w{high-protein comforting familiar black-and-white}; end
  def resources; choose Noun, %w{food stories jobs sights}; end

  # and you stop consuming resources either because you're full
  def full; choose Adjective, %w{energetic responsible frustrated convinced}; end
  # which is a sign you can go splurge

  # or because you are overwhelmed
  def overwhelmed; choose Adjective, %w{sick helpless angry afraid}; end
  # which is a sign that you're about to reject the triggers (and nons)
  def reject
    if index == 0
      Phrase.new [Verb.new("throw"), "up"]
    else
      choose Verb, %w{NIL cry quit panic}
    end
  end

  # kinetic energy is converted to and from potential energy
  def potentials; choose Noun, %w{weight friends savings memories}; end

  # you don't need potentials if the resources are abundant and tolerable
  def tolerate; choose Verb, %w{stomach hear handle believe}; end

  # but you must have essentials
  def critical; choose Adjective, %w{essential happy retirement true}; end
  def stores; choose Noun, %w{fat endings savings beliefs}; end
  def essentials; Phrase.new [critical, stores]; end

  # running out of kinetics and tapping into potentials
  def empty; choose Adjective, %w{hungry lonely purse-pinched sure}; end

  # running out of kinetics and tapping into essentials
  def dying; choose Adjective, %w{starving suicidal destitute clueless}; end

  def die_verb; choose Verb, %w{starve commit go make}; end
  def die_mid; choose Word, %w{to NIL NIL a\ fatal}; end
  def die_noun; choose Noun, %w{death suicide bankrupt mistake}; end
  def die; Phrase.new [die_verb, die_mid, die_noun]; end
end
