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

  def self.first; self::ALL.first; end
  def self.second; self::ALL.second; end
  def self.third; self::ALL.third; end
  def self.fourth; self::ALL.fourth; end
  def self.last; self::ALL.last; end

  def next; self.class::ALL[index+1] || self.class.first; end
  def previous; self.class::ALL[index-1] || self.class.last; end

  def others; self.class::ALL - [self]; end
  def other
    if others.size == 1
     others.first
    else
     raise "too many: #{others.size} others in #{self.class}"
    end
  end

  def word; %w{alpha beta psi omega}[index]; end
  def name; words.titleize.squash rescue word.capitalize ; end

end
