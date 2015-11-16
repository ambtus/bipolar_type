class Energy < Noun

  LETTERS = %w{S F T N }
  def self.paths; LETTERS.map(&:downcase); end

  def initialize(string)
    raise "#{string} is not a type of energy" unless LETTERS.include? string
    super
  end

  ALL = LETTERS.collect{|letter| self.new letter}
  def self.all; ALL; end
  LETTERS.each do |letter|
    define_singleton_method(letter.downcase) {all[LETTERS.index letter]}
  end
  def others; ALL.collect{|nature| nature != self}; end

  def index; LETTERS.index(string); end
  def <=>(other); index <=> other.index; end
  def subtypes; Subtype.all.select{|s| s.energy == self}; end

  def choose(klass, array); klass.new array[index]; end

  def domain; choose Adjective, %w{physical spiritual financial cognitive}; end
  def name; Phrase.new [domain.capitalize, parenthetical]; end

  def sense; choose Verb, %w{smell hear touch see}; end
  def consume; choose Verb, %w{eat listen earn look}; end
  def get; choose Verb, %w{eat hear work see}; end
  def organs; choose Noun, %w{teeth ears hands eyes}; end

  # the external object
  def resource; choose Noun, %w{meal story job picture}; end

  # external signal: positive affect
  def seem; choose Verb, %w{smell sound feel look}; end
  def good; choose Adjective, %w{appetizing funny urgent colorful}; end
  def goodness; choose Adjective, %w{appetite laughter urgent color}; end
  def resource_seems_good; Phrase.new [resource, seem.s, good]; end

  # external signal: negative affect
  def reality; choose Noun, %w{taste speaker task subject}; end
  def bad; choose Adjective, %w{bitter angry painful close}; end
  def badness; choose Noun, %w{bitterness anger pain proximity }; end
  def reality_is_too_bad; Phrase.new [reality, "is", "too", bad]; end

  # internal signal: negative affect
  def empty; choose Adjective, %w{hungry hopeless indebted worried}; end
  def emptiness; choose Adjective, %w{hunger hopelessness debt anxiety}; end

  # internal signal: positive affect. I feel
  def full; choose Adjective, %w{satisfied loved rewarded convinced}; end
  def fullness; choose Noun, %w{satisfaction love reward conviction}; end
  # the resource was
  def filling; choose Adjective, %w{satisfying loving rewarding convincing}; end

  # neurochemical
  def neuro; choose Noun, %w{serotonin oxytocin dopamine GABA}; end
  def triggers; choose Noun, %w{simple\ carbs romance wages recognizable\ details}; end
  def triggery; choose Adjective, %w{sweet romantic paid familiar}; end
  def strengths; choose Noun, %w{protein tragedies investments patterns}; end

  # stored energy
  def potentials; choose Noun, %w{weight optimism wealth information}; end
  def essentials; choose Noun, %w{fat hope assets knowledge}; end
  # so you can produce without stopping to consume first
  def produce; choose Verb, %w{move talk spend decide}; end
  # instead of dying of
  def death; choose Noun, %w{starvation suicide exposure stupidity}; end

end
