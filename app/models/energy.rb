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

  def realm; choose Adjective, %w{physical emotional financial mental}; end
  def name; Phrase.new [realm.capitalize, parenthetical]; end

  def produce; choose Verb, %w{walk communicate buy decide}; end
  def consume; choose Verb, %w{eat listen work look}; end

  # the external object
  def resources; choose Noun, %w{meal stories job show}; end

  # external signal: positive affect
  def seem; choose Verb, %w{smell sound feel look}; end
  def seem_if; resources.if_uncountable(seem.s, seem); end
  def good; choose Adjective, %w{appetizing harmonious easy beautiful}; end
  def resources_seem_good; Phrase.new [resources, seem_if, good]; end

  # external signal: negative affect
  def are; choose Verb, %w{taste sound feel look}; end
  def are_if; resources.if_uncountable(are.s, are); end
  def bad; choose Adjective, %w{bitter hateful painful chaotic}; end
  def resources_are_bad; Phrase.new [resources, are_if, bad]; end

  # internal signal: negative affect
  def empty; choose Adjective, %w{hungry responsible indebted anxious}; end

  # internal signal: positive affect
  def full; choose Adjective, %w{satisfied moved rewarded convinced}; end
  def filling; chose Adjective, %w{satisfying moving rewarding convincing}; end

  # neurochemical
  def triggers; choose Adjective, %w{desert happy\ ending bonus conclusion}; end
  def triggery; choose Adjective, %w{sweet sentimental highly\ paid colorful}; end

  # stored energy
  def potentials; choose Noun, %w{weight emotions wealth information}; end
  def essentials; choose Noun, %w{fat values savings knowledge}; end

end
