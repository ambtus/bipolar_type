class Concept
  SYMBOLS = %i{X Y Z}

  def initialize(symbol); @symbol = symbol; end
  attr_reader :symbol
  alias inspect :symbol
  def string; symbol.to_s; end

  ALL = SYMBOLS.collect { |symbol| self.new symbol }
  SYMBOLS.each do |sym|
    define_singleton_method(sym) { ALL.find { |s| s.symbol == sym } }
  end

  class << self
    def symbols; self::SYMBOLS; end
    def strings; self::SYMBOLS.map(&:to_s); end

    def all; self::ALL; end
    def rotate(i = 1); all.rotate(i); end
    def [](i); (all * 2)[i]; end
    def first; all.first; end
    def second; all.second; end
    def third; all.third; end
    def fourth; all.fourth; end
    def last; all.last; end
    def each(&block); all.each(&block); end
    def each_with_index(&block); all.each_with_index(&block); end
    def find(s); all.find { |x| x.symbol == s.to_sym }; end
    def title; [all.count, self.name.pluralize].to_phrase; end
  end

  def index; self.class::SYMBOLS.index(@symbol); end

  def next; self.class.rotate[index]; end
  def previous; self.class.rotate(-1)[index]; end
  def opposite; self.class.rotate(2)[index]; end

  def compound?; respond_to? :parts; end

  def <=>(other)
    if compound?
      self.parts <=> other.parts
    else
      self.index <=> other.index
    end
  end
end
