class Concept

  def initialize(symbol); @symbol = symbol; end
  attr_reader :symbol
  def inspect; @symbol; end

  ########
  SYMBOLS = %w{A B C D}
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  SYMBOLS.each {|s| define_singleton_method(s) {ALL[SYMBOLS.index(s)]}}
  ########

  def index; self.class::SYMBOLS.index @symbol; end
  def <=>(other); self.index <=> other.index; end

  def self.all; self::ALL; end
  def self.each(&block);self::ALL.each(&block); end
  def self.each_with_index(&block);self::ALL.each_with_index(&block); end
  def self.collect(&block);self::ALL.collect(&block); end
  def self.select(&block);self::ALL.select(&block); end
  def self.map(&block);self::ALL.map(&block); end
  def self.[](*args);self::ALL[*args]; end

  %w{first second third fourth last}.each do |ordinal|
    define_singleton_method(ordinal) {all.send(ordinal)}
  end

  def word; %w{alpha beta gamma delta}[index]; end
  def name; words.to_wbr.html_safe rescue word.capitalize ; end

end
