class Position

  def initialize(symbol, name); @symbol = symbol; @name = name; end
  attr_reader :symbol, :name

  SYMBOLS = %w{IP EP EJ IJ}
  NAMES = %w{Morning Midday Afternoon Night}
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

  def name; @name.titleize; end
  def inspect; "#{@symbol}: #{name}"; end

  def path; @symbol; end

  def index; SYMBOLS.index @symbol; end
  def next; ALL[index + 1] || Position.first; end
  def previous; ALL[index - 1] || Position.fourth; end

  def severity; [0,3].include?(index) ? "reactive" : "primary"; end
  def episode; index < 2 ? "depression" : "mania"; end
  def description; [severity, episode].join(" "); end

end
