class Concept

  def initialize(symbol); @symbol = symbol; end
  attr_reader :symbol
  def inspect; @symbol; end

  ########
  SYMBOLS = %w{A B Y Z}
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  SYMBOLS.each {|s| define_singleton_method(s) {ALL[SYMBOLS.index(s)]}}
  ########

  def self.all; self::ALL; end
  def self.each(&block);self::ALL.each(&block); end

  def self.first; self::ALL.first; end


  def word; %w{alpha beta psi omega}[index]; end
  def name; words.titleize.squash rescue word.capitalize ; end


  def index; self.class::SYMBOLS.index @symbol; end

  def others; self.class::ALL - [self]; end
  def other
    if others.size == 1
     others.first
    else
     raise "too many others"
    end
  end

end
