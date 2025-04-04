class Concept

  SYMBOL = %w{X Y Z}

  def initialize(symbol); @symbol = symbol; end
  attr_reader :symbol
  alias inspect :symbol

  ALL = SYMBOL.collect {|symbol| self.new symbol}
  SYMBOL.each do |sym|
    define_singleton_method(sym) {ALL.find{|s| s.symbol == sym}}
  end

  class << self
    def all; self::ALL; end
    def first; all.first; end
    def second; all.second; end
    def third; all.third; end
    def fourth; all.fourth; end
    def symbols; self::SYMBOL; end
    def each(&block); self::ALL.each(&block); end
    def title; [self::ALL.count, self.name.pluralize].to_phrase; end
    def find_by(symbol); self::ALL.find{|x| x.symbol == symbol}; end
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
