class Realm

  def initialize(symbol, name); @symbol = symbol; @name = name; end
  attr_reader :symbol, :name

  SYMBOLS = %w{S N F T}
  NAMES = %w{physical mental spiritual/social material/financial}
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

  def name; @name.titleize; end
  def inspect; "#{@symbol}: #{name}"; end

  def path; @symbol; end

  def index; SYMBOLS.index(@symbol) ; end

  def energy; %w{calories facts morals money}[index]; end
  def strengths; %w{muscles theories\ or\ procedures\ or\ generalities language\ or\ vocabulary credit/debts}[index]; end
  def notice; %w{smell/taste see hear touch}[index]; end
  def process; %w{eat\ &\ digest watch\ &\ learn listen\ &\ understand hold\ &\ use}[index]; end
  def resources; %w{foods events/results stories\ or\ songs tools\ (goods\ or\ services)}[index]; end
  def fast_energy; %w{simple\ carbs colorful\ details music\ and\ intonation hourly\ wages\ or\ cash\ sales}[index]; end
  def slow_energy; %w{protein stable\ patterns lyrics\ and\ words monthly\ salaries\ or\ investment\ interest\ &\ dividends}[index]; end
  def energetic_action; %w{walk\ or\ run guess\ or\ choose talk,\ sing\ or\ cry pay\ cash\ upfront}[index]; end
  def strong_action; %w{lift\ weights prove\ or\ plan write charge\ or\ lease\ or\ rent}[index]; end


end
