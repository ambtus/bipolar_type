class Concept

  def initialize(symbol); @symbol = symbol; end
  attr_reader :symbol
  def inspect; @symbol; end

  ########
  SYMBOLS = %w{A B Y Z}
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  SYMBOLS.each {|s| define_singleton_method(s) {ALL[SYMBOLS.index(s)]}}
  ########

  def index; self.class::SYMBOLS.index @symbol; end
  def <=>(other); self.index <=> other.index; end

  def self.all; self::ALL; end
  def self.each(&block);self::ALL.each(&block); end

  %w{first second third fourth last}.each do |ordinal|
    define_singleton_method(ordinal) {all.send(ordinal)}
  end

  def next; self.class::ALL[index+1] || self.class.first; end
  def previous; self.class::ALL[index-1] || self.class.last; end
  def opposite; (self.class::ALL + self.class::ALL)[index + self.class::ALL.size/2]; end

  def word; %w{alpha beta psi omega}[index]; end
  def name; words.titleize.squash rescue word.capitalize ; end

end
