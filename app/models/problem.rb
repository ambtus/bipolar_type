class Problem

  NAMES = %w{ Anorexic Obese Depressed Manic }
  SYMBOLS = NAMES.map(&:first)

  def initialize(symbol); @symbol = symbol; end
  attr_reader :symbol
  alias path :symbol

  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  def self.all; ALL; end
  def self.each(&block);self.all.each(&block); end

  SYMBOLS.each_with_index do |symbol, index|
    define_singleton_method(symbol) {Problem.all[index]}
    define_singleton_method(symbol.downcase) {Problem.all[index]}
  end

  def index; SYMBOLS.index @symbol; end
  def <=>(other); index <=> other.index; end

  def subtypes; Subtype.all.select{|s| s.problem == self}; end
  def +(realm); subtypes.find{|s| s.realm == realm}; end

  def name; NAMES[index]; end
  alias inspect :name
  def adjective; name.downcase; end

  def noun; adjective.to_noun; end

end
