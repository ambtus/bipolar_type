class Realm

  def initialize(symbol, name); @symbol = symbol; @name = name; end
  attr_reader :symbol, :name

  SYMBOLS = %w{S T F N}
  NAMES = %w{physical material spiritual mental}
  ALL = 4.times.collect {|i| new SYMBOLS[i], NAMES[i]}

  SYMBOLS.each do |symbol|
    define_singleton_method(symbol) {ALL[SYMBOLS.index(symbol)]}
  end
  class << self
    def all; ALL; end
    def each(&block); ALL.each(&block); end
    def each_with_index(&block); ALL.each_with_index(&block); end
    def symbols; SYMBOLS; end
  end

  def name; @name.titleize; end
  def inspect; "#{@symbol}: #{name}"; end

  def path; @symbol; end

  def index; SYMBOLS.index(@symbol) ; end

  def accept; %w{eat use say follow}[index]; end
  def things; %w{foods tools words plans}[index]; end

  def description
    "#{accept} the #{things}"
  end

end
