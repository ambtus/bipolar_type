class Concept

  def initialize(letter); @letter = letter; end
  def inspect; @letter; end
  def path; @letter; end
  def symbol; @letter.upcase ; end
  def locale; @letter.to_sym; end

  ########
  ACRONYMS = %w{a b c d}
  ALL = ACRONYMS.collect {|letter| self.new letter}
  ACRONYMS.each {|letter| define_singleton_method(letter) { ALL[ACRONYMS.index(letter)] } }
  ########

  def self.all; self::ALL; end
  def self.paths; self::ACRONYMS; end

  def others
    raise "not enough members" unless self.class.all.size > 2
    self.class.all.select{|i| i != self}
  end
  def other
    raise "too many members" unless self.class.all.size == 2
    self.class.all.select{|i| i != self}.first
  end

  def index; self.class::ACRONYMS.index @letter; end
  def <=>(other); index <=> other.index; end
  def ordinal; %w{first second third fourth}[index]; end

end
