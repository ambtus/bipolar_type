class Concept

  def initialize(letter); @letter = letter; end

  ########
  ACRONYMS = %w{a b c d}
  ALL = ACRONYMS.collect {|letter| self.new letter}
  ACRONYMS.each do |letter|
    define_singleton_method(letter) {ALL[ACRONYMS.index(letter)]}
  end
  %w{first second third fourth}.each_with_index do |ordinal, index|
    define_singleton_method(ordinal) {ALL[index]}
  end
  ########

  def self.paths; self::ACRONYMS; end
  def self.all; self::ALL; end

  def inspect; @letter; end
  def path; @letter; end
  def symbol; @letter.upcase; end

  def index; self.class::ACRONYMS.index @letter; end
  def <=>(other); index <=> other.index; end

  def ordinal; %w{first second third fourth}[index]; end
end
