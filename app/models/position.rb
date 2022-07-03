class Position

  def initialize(symbol, name); @symbol = symbol; @name = name; end
  attr_reader :symbol, :name

  SYMBOLS = %w{🀦 🀧 🀨 🀩}
  NAMES = %w{spring summer autumn winter}
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

  def action; %w{wake sow reap sleep}[index]; end
  def time; %w{morning noon evening night}[index]; end

  def long
    case index
    when 0
      "rev up"
    when 1
      "use energy"
    when 2
      "get energy"
    when 3
      "calm down"
    end
  end

  def description(realm)
    case index
    when 0
      "start #{realm.getting} to wake up in the morning"
    when 1
      "start #{realm.using} to #{realm.output} during the day"
    when 2
      "stop #{realm.using} to #{realm.intake} in the evening"
    when 3
      "stop #{realm.getting} to fall asleep in the evening"
    end
  end

  def definition; "#{time} (#{action}; #{long})"; end

end
