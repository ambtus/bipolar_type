class Concept

  SYMBOL = %w{A B X Y}

  def initialize(symbol); @symbol = symbol; end
  attr_reader :symbol
  alias inspect :symbol

  ALL = SYMBOL.collect {|symbol| self.new symbol}

  class << self
    def all; self::ALL; end
    def symbols; self::SYMBOL; end
    def each(&block); self::ALL.each(&block); end
    def compound?; self::ALL.first.compound?; end
    def title
      #if compound?
        [self::ALL.count, self.name.pluralize].to_phrase
      #else
       # self::SYMBOL.join
      #end
    end
    def find_by(symbol); self::ALL.find{|x| x.symbol == symbol}; end
  end

  def opposite; self.class::ALL.without(self).first; end

  def index; self.class::SYMBOL.index(@symbol); end
  def <=>(other)
    if compound?
      self.parts <=> other.parts
    else
      self.index <=> other.index
    end
  end

  def compound?; respond_to? :parts; end

  def words; Rails.application.config_for(:words)[symbol]; end

end
