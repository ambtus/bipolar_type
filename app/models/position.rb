class Position

  def initialize(symbol, name); @symbol = symbol; @name = name; end
  attr_reader :symbol, :name

  SYMBOLS = %w{ 📤 🔥 📥 🧊 }
  NAMES = %w{productivity mania receptivity depression}
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
  def inspect; "#{@symbol}#{title}"; end

  def path; @symbol; end

  def index; SYMBOLS.index @symbol; end
  def next; ALL[index + 1] || Position.first; end

  def x_energy; %w{use lose get gain}[index]; end
  def energy_x; %w{output deficit intake surplus }[index]; end

  def definition; "energy #{energy_x} (#{x_energy} energy)"; end

  def bipolar?; index.odd? ; end
  def state; index < 2 ? "skinny" : "fat" ; end

end
