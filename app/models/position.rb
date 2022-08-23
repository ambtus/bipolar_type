class Position

  def initialize(symbol, name); @symbol = symbol; @name = name; end
  attr_reader :symbol, :name

  SYMBOLS = %w{I P E J}
  NAMES = %w{intake transformation extraction control}
  ALL = 4.times.collect {|i| new SYMBOLS[i], NAMES[i]}

  # class methods
  %w{first second third fourth}.each_with_index do |ordinal, index|
    define_singleton_method(ordinal) {ALL[index]}
  end
  SYMBOLS.each do |symbol|
    define_singleton_method(symbol) {ALL[SYMBOLS.index(symbol)]}
  end
  class << self
    def all; ALL; end
    def each(&block); ALL.each(&block); end
    def each_with_index(&block); ALL.each_with_index(&block); end
  end

  def title; @name.titleize; end
  def inspect; "#{@symbol}: #{title}"; end

  def path; @symbol; end

  def index; SYMBOLS.index @symbol; end
  def next; ALL[index + 1] || Position.first; end
  def previous; ALL[index - 1] || Position.fourth; end

  def mbti; %w{I P J E}[index]; end

  def description
    case index
    when 0
      "get energy from the wholes"
    when 1
      "create wholes from the parts"
    when 2
      "get parts from your environment"
    when 3
      "create your environment from the world"
    end
  end

end
