class Realm

  NAMES = %w{Physical Financial Mental Affective Bipolar}
  SYMBOLS = NAMES.map(&:first)

  def initialize(symbol); @symbol = symbol; end
  def symbol; @symbol == 'B' ? '' : @symbol; end
  alias path :symbol

  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  def self.all; ALL[0,4]; end
  def self.each(&block);ALL[0,4].each(&block); end

  SYMBOLS.each_with_index do |symbol, index|
    define_singleton_method(symbol) {ALL[index]}
    define_singleton_method(symbol.downcase) {ALL[index]}
  end

  def index; SYMBOLS.index @symbol; end
  def <=>(other); index <=> other.index; end

  def subtypes; Subtype.all.select{|s| s.realm == self}; end
  def +(problem); subtypes.find{|s| s.problem == problem}; end

  def name; NAMES[index]; end
  alias inspect :name
  def adjective; name.downcase; end
  def adverb; adjective + "ly"; end

  def energy; %w{calories money information emotions}[index]; end
  def strengths; %w{muscles credit rules vocabulary}[index]; end

  def get; %w{eat earn look\ at listen\ to get}[index]; end
  def process; %w{digest collect learn understand process}[index]; end
  def energizers; %w{carbs wages the\ details music energy}[index]; end
  def get_energy; [get, energizers].to_phrase; end
  def process_energy; [process, energizers].to_phrase; end
  def strengtheners; %w{protein a\ salary the\ results the\ words strength}[index]; end
  def get_strength; [get, strengtheners].to_phrase; end
  def process_strength; [process, strengtheners].to_phrase; end

  def use_energy; %w{run pay\ cash decide emote use\ energy}[index]; end
  def use_strength; %w{lift\ weights use\ credit theorize write use\ strength}[index]; end
  def use; %w{move buy predict explain}[index]; end

  def organ; %w{body wallet}[index]; end

  def period; %w{day year month week}[index]; end
end
