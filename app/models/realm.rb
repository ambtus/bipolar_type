class Realm

  def initialize(symbol, name); @symbol = symbol; @name = name; end
  attr_reader :symbol, :name

  SYMBOLS = %w{😷 🧐 🥰 🤑}
  NAMES = %w{physical mental spiritual material}
  ALL = 4.times.collect {|i| new SYMBOLS[i], NAMES[i]}

  ARROWS = %w{ high up down low }
  GENERICS = 4.times.collect {|i| new ARROWS[i], "towards_#{Position.all[i].next.name}"}

  # class methods
  %w{first second third fourth}.each_with_index do |ordinal, index|
    define_singleton_method(ordinal) {ALL[index]}
  end
  SYMBOLS.each do |symbol|
    define_singleton_method(symbol) {ALL[SYMBOLS.index(symbol)]}
  end
  ARROWS.each do |arrow|
    define_singleton_method(arrow) {GENERICS[ARROWS.index(arrow)]}
  end
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

  def energy; %w{calories facts affect money energy}[index]; end
  def get; %w{eat watch listen sell intake}[index]; end
  def getting; %w{ eating watching listening selling intaking}[index]; end
  def use; %w{move think care buy output}[index]; end
  def using; %w{moving thinking caring buying outputing}[index]; end

  def definition; "get and use #{energy} (#{get} and #{use})"; end

  def adjective; @name; end
  def adverb; adjective + "ly"; end

  def towards_mania;       "Using #{energy} (#{using}) is easy but #{getting} is hard"; end
  def towards_depression;  "Getting #{energy} (#{getting}) is easy but #{using} is hard"; end
  def towards_receptivity; "Using #{energy} (#{using}) is constant but #{getting} is intermittent"; end
  def towards_productivity;"Getting #{energy} (#{getting}) is constant but #{using} is intermittent"; end
end
