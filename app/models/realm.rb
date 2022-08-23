class Realm

  def initialize(symbol, name); @symbol = symbol; @name = name; end
  attr_reader :symbol, :name

  SYMBOLS = %w{F S T N}
  NAMES = %w{affect calories money probabilities}
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

  def title; adjective.titleize; end
  def inspect; "#{@symbol}: #{title}"; end

  def path; @symbol; end

  def index; SYMBOLS.index(@symbol) ; end

  def energy; @name; end
  def adjective; %w{spiritual physical material mental}[index]; end
  def adverb; "#{adjective}ly"; end
  def give; %w{sing\ to feed show pay }[index]; end
  def take; %w{listen eat sell learn}[index]; end
  def transform; %w{harmonize cook build collate}[index]; end
  def gather; %w{ask labor invest analyze}[index]; end
  def control; %w{proselytize emigrate design research}[index]; end

  def wholes; %w{harmony foods ?? rules}[index]; end
  def parts; %w{voices ingredients parts results}[index]; end
  def environ; %w{community farms tools experiments}[index]; end
  def world; %w{people places things possibilities}[index]; end

  def description
    "get #{energy} from #{world}"
  end

end
