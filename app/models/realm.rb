class Realm

  def initialize(symbol, name); @symbol = symbol; @name = name; end

  SYMBOLS = %w{ 😷 🧐 🤑 🥰 }
  NAMES = %w{Physical Mental Financial Emotional}
  ALL = 4.times.collect {|i| new SYMBOLS[i], NAMES[i]}

  attr_reader :name, :symbol

  # class methods
  %w{first second third fourth}.each_with_index do |ordinal, index|
    define_singleton_method(ordinal) {ALL[index]}
  end
  SYMBOLS.each do |symbol|
    define_singleton_method(symbol) {ALL[SYMBOLS.index(symbol)]}
  end
  NAMES.each do |name|
    define_singleton_method(name.downcase) {ALL[NAMES.index(name)]}
  end
  class << self
    def each(&block); ALL.each(&block); end
    def each_with_index(&block); ALL.each_with_index(&block); end
    def symbols; SYMBOLS; end
    def names; NAMES; end
    def shorts; names.map(&:first); end
  end

  def inspect; "#{@name}#{@symbol}"; end

  def path; @name.downcase; end
  def adverb; path.ly; end
  def adjective; path; end

  def index; SYMBOLS.index @symbol; end

  def energy; %w{calories facts money love}[index]; end
  def get; %w{eat watch earn hear }[index]; end
  def use; %w{exercise think spend care }[index]; end

  def process; %w{digest analyze sell understand }[index]; end
  def process_alt; %w{eat look\ at sell listen\ to }[index]; end
  def resources; %w{foods results goods/services words }[index]; end
  def receive; [process, resources].to_phrase; end
  def appear; %w{smell look feel sound }[index]; end

  def achieve; %w{go create buy tell }[index]; end
  def results; %w{places solutions things people }[index]; end
  def something; %w{somewhere something something someone }[index]; end

  def produce; [achieve, results].to_phrase; end

end
