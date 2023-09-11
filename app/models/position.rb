class Position

  def initialize(symbol); @symbol = symbol; end
  attr_reader :symbol, :name

  SYMBOLS = %w{IJ IP EJ EP}
  ALL = 4.times.collect {|i| new SYMBOLS[i]}

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

  def subtypes; Subtype.all.select{|s| s.position == self}; end

  def index; SYMBOLS.index @symbol; end
  def surplus_or_deficit; index > 1 ? "surplus" : "deficit"; end
  def manic_or_depressed; index > 1 ? "depressed" : "manic"; end
  def problem; "#{manic_or_depressed} #{surplus_or_deficit}"; end

  def get_or_use; index.even? ? "use" : "get"; end
  def more_or_less; [0,3].include?(index) ? "less" : "more"; end
  def solution; "#{get_or_use} #{more_or_less}"; end
  def description; "#{problem} (#{solution})" ; end
  def name; solution.titleize; end

  def inspect; "#{@symbol}: #{name}"; end

  def path; @symbol; end

  def reason
    case index
    when 0
      "cannot get enough when manic"
    when 1
      "use too much when manic"
    when 2
      "get too much when depressed"
    when 3
      "cannot use enough when depressed"
    end
  end

end
