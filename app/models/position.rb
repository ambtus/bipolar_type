class Position

  def initialize(symbol); @symbol = symbol; end
  attr_reader :symbol
  alias path :symbol
  alias inspect :symbol

  SYMBOLS = %w{1 2 3 4}
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  def self.all; ALL[0,4]; end
  def self.each(&block);ALL.each(&block); end
  def index; SYMBOLS.index @symbol; end

  def inferior?; index == 3 ; end
  def self.inferior; ALL.last; end
  def mbti; inferior? ? '' : "&sup#{symbol};".html_safe; end

  NAMES = %w{Dominant Auxiliary Tertiary Inferior}
  def name; NAMES[index]; end
  def symbolic_name; [symbol.colon, name].to_safe_phrase; end

  ALL.each_with_index do |instance, index|
    %w{name}.each do |thing|
      define_singleton_method(instance.send(thing)) {ALL[index]}
      define_singleton_method(instance.send(thing).downcase) {ALL[index]}
    end
  end
  %w{first second third fourth}.each do |ordinal|
    define_singleton_method(ordinal) {ALL.send(ordinal)}
  end


  def subtypes; Subtype.all.select{|s| s.position == self}; end
  def +(behavior); subtypes.find{|s| s.behavior == behavior}; end

end
