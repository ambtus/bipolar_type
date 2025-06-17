class Concept

  SYMBOLS = %i{X Y Z}

  def initialize(symbol); @symbol = symbol; end
  attr_reader :symbol
  alias inspect :symbol
  def string; symbol.to_s; end

  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  SYMBOLS.each do |sym|
    define_singleton_method(sym) {ALL.find{|s| s.symbol == sym}}
  end

  class << self
    def all; self::ALL; end
    def rotate(i=1); all.rotate(i); end
    def first; all.first; end
    def second; all.second; end
    def third; all.third; end
    def fourth; all.fourth; end
    def symbols; self::SYMBOLS; end
    def strings; self::SYMBOLS.map(&:to_s); end
    def each(&block); self::ALL.each(&block); end
    def title; [self::ALL.count, self.name.pluralize].to_phrase; end
    def find(s); self::ALL.find{|x| x.symbol == s.to_sym}; end
  end

  def index; self.class::SYMBOLS.index(@symbol); end

  def compound?; respond_to? :parts; end
  def <=>(other)
    if compound?
      self.parts <=> other.parts
    else
      self.index <=> other.index
    end
  end

end
