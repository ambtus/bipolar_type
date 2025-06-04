class Concept

  SYMBOL = %i{X Y Z}

  def initialize(symbol); @symbol = symbol; end
  attr_reader :symbol
  alias inspect :symbol
  def string; symbol.to_s; end

  ALL = SYMBOL.collect {|symbol| self.new symbol}
  SYMBOL.each do |sym|
    define_singleton_method(sym) {ALL.find{|s| s.symbol == sym}}
  end

  class << self
    def all; self::ALL; end
    def rotate(i=1); all.rotate(i); end
    def first; all.first; end
    def second; all.second; end
    def third; all.third; end
    def fourth; all.fourth; end
    def symbols; self::SYMBOL; end
    def each(&block); self::ALL.each(&block); end
    def title; [self::ALL.count, self.name.pluralize].to_phrase; end
    def find_by(s); self::ALL.find{|x| x.symbol == s.to_sym}; end
  end

  def index; self.class::SYMBOL.index(@symbol); end

  def compound?; respond_to? :parts; end
  def <=>(other)
    if compound?
      self.parts <=> other.parts
    else
      self.index <=> other.index
    end
  end

end
