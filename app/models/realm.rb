class Realm

  NAMES = %w{Physical Financial Mental Affective }
  SYMBOLS = NAMES.map(&:first)

  def initialize(symbol); @symbol = symbol; end
  attr_reader :symbol
  alias path :symbol

  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  def self.all; ALL; end
  def self.each(&block);ALL.each(&block); end

  SYMBOLS.each_with_index do |symbol, index|
    define_singleton_method(symbol) {Realm.all[index]}
    define_singleton_method(symbol.downcase) {Realm.all[index]}
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

  def get; %w{eat compete\ for learn listen\ to}[index]; end
  def energizers; %w{carbs rewards details tunes}[index]; end
  def strengtheners; %w{protein returns generalizations words}[index]; end
  def get_energy; [get, energizers].to_phrase; end
  def get_strength; [get, strengtheners].to_phrase; end

  def use_energy; %w{walk pay\ cash guess talk}[index]; end
  def use_strength; %w{lift\ weights use\ credit theorize write}[index]; end
  def use; %w{move buy predict explain}[index]; end

  def organ; %w{body wallet}[index]; end

  def period; %w{day year month week}[index]; end
end
