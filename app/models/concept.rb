class Concept

  def initialize(symbol); @symbol = symbol; end
  SYMBOLS = %w{α β γ δ}
  PATHS = %w{a b c d}

  ########
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  PATHS.each do |path|
    define_singleton_method(path) {ALL[PATHS.index(path)]}
  end
  %w{first second third fourth}.each_with_index do |ordinal, index|
    define_singleton_method(ordinal) {self::ALL[index]}
  end
  ########

  def self.paths; self::SYMBOLS; end
  def self.all; self::ALL; end

  def self.each(&block);self::ALL.each(&block); end

  def inspect; @symbol; end
  def symbol; @symbol; end

  def index; self.class::SYMBOLS.index @symbol; end
  def <=>(other); index <=> other.index; end

  def others; self.class::ALL - [self]; end
  def other; (self.class::ALL - [self]).first; end

  def path; PATHS[index]; end
  def adjective; %w{alpha beta gamma delta}[index]; end
  def name; adjective.capitalize; end
  def ordinal; %w{first second third fourth}[index]; end

  def first?; self.ordinal == "first"; end
  def last?; self.ordinal == "fourth"; end

  def self.names; self::ALL.map(&:name).to_sentence; end
end
