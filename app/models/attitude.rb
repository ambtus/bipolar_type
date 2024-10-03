class Attitude

  SYMBOL = %w{EP EJ IP IJ}

  def initialize(symbol); @symbol = symbol; end
  attr_reader :symbol
  alias path :symbol
  alias inspect :symbol

  ALL = SYMBOL.collect {|symbol| self.new symbol}
  SYMBOL.each_with_index do |symbol, index|
    define_singleton_method(symbol) {ALL[index]}
    define_singleton_method(symbol.downcase) {ALL[index]}
  end
  def index; SYMBOL.index @symbol; end
  def <=>(other); self.index <=> other.index; end

  class << self
    def all; ALL; end
    def each(&block); ALL.each(&block); end
    def pairs; all.combination(2); end
  end

  constants.each do |constant|
    define_method(constant.downcase) {self.class.const_get(constant)[index]}
  end

  def bipolar; Bipolar.send(symbol.first); end
  def phase; Phase.send(symbol); end

  def wont?; %w{EP IJ}.include? symbol; end

  def episode(function); phase.episode.words.insert(-2, function.adjective).to_phrase; end


  def method_missing(meth, *args, **kwargs, &block)
    if phase.respond_to?(meth)
      phase.send(meth)
    elsif bipolar.respond_to?(meth)
      bipolar.send(meth)
    else
      super(meth)
    end
  end

end
