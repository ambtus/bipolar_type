class Energy < Noun

  LETTERS = %w{S T F N }

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

  def choose(klass, array); klass.new array[index]; end

  def potential; choose Noun, %w{weight  savings friends memories}; end

  def gain; choose Verb, %w{eat earn listen look}; end
  def full; choose Adjective, %w{restless rich liked sure}; end

  def lose; choose Verb, %w{walk spend talk decide}; end
  def empty; choose Adjective, %w{hungry indebted ignored anxious}; end

  def sensory_signals; choose Noun, %w{smells pain sounds sights}; end

end
