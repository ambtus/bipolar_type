class Realm

  def initialize(symbol); @symbol = symbol; end
  attr_reader :symbol

  SYMBOLS = %w{S N F T}
  ALL = 4.times.collect {|i| new SYMBOLS[i]}

  SYMBOLS.each do |symbol|
    define_singleton_method(symbol) {ALL[SYMBOLS.index(symbol)]}
  end
  class << self
    def all; ALL; end
    def each(&block); ALL.each(&block); end
    def each_with_index(&block); ALL.each_with_index(&block); end
    def symbols; SYMBOLS; end
  end

  def center; %w{calories knowledge motivation money}[index]; end
  def adjective; %w{caloric knowledge motivational monetary}[index]; end
  def name; center.capitalize; end
  def inspect; "#{@symbol}: #{name}"; end

  def path; @symbol; end

  def index; SYMBOLS.index(@symbol) ; end


  def get; %w{eat watch listen\ to earn\ from}[index]; end
  def get_short; get.split(" ").first; end
  def external_less; %w{fewer fewer less less}[index]; end
  def external_energy; %w{carbs colors music wages}[index]; end
  def external_strength; %w{protein movement words investments}[index]; end
  def get_energy; "#{get} #{external_energy}"; end
  def get_strength; "#{get} #{external_strength}"; end
  def get_less_energy; "#{get} #{external_less} #{external_energy}"; end

  def use; %w{move decide communicate spend}[index]; end
  def internal_energy; %w{glycogen specifics emotion cash}[index]; end
  def use_energy; "#{use} using #{internal_energy}"; end
  def internal_strength; %w{muscles rules meaning credit}[index]; end
  def use_strength; "#{use} using #{internal_strength}"; end

end
