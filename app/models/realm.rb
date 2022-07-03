class Realm

  def initialize(symbol, name); @symbol = symbol; @name = name; end
  attr_reader :symbol, :name

  SYMBOLS = %w{🥰 😷 🤑 🧐}
  NAMES = %w{emotions calories currency facts}
  ALL = 4.times.collect {|i| new SYMBOLS[i], NAMES[i]}

  class << self
    def all; ALL; end
    def generics; GENERICS; end
    def each(&block); ALL.each(&block); end
    def each_with_index(&block); ALL.each_with_index(&block); end
    def symbols; SYMBOLS; end
  end

  def title; @name.titleize; end
  def inspect; "#{@symbol}#{title}"; end

  def path; @symbol; end

  def index; SYMBOLS.index(@symbol) || 4 ; end

  def get; %w{listen taste touch look}[index]; end
  def getting; %w{listening tasting touching looking}[index]; end
  def use; %w{care move buy think}[index]; end
  def using; %w{caring moving buying thinking}[index]; end

  def iverb; %w{understand eat use analyze}[index]; end
  def inoun; %w{voices foods tools events}[index]; end
  def intake; [iverb, inoun].join(" "); end

  def overb; %w{tell go build plan}[index]; end
  def onoun; %w{people places things actions}[index]; end
  def output; [overb, onoun].join(" "); end

  def definition; "#{use} (#{output}) and #{get} (#{intake})"; end

end
