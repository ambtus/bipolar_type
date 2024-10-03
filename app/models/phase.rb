class Phase

  SYMBOL = %w{IP EP IJ EJ}
  SEASON = %w{spring summer autumn winter}
  TIME = %w{morning midday afternoon evening}
  PHASE = %w{waxing full waning new }
  WEEK = %w{ monday wednesday friday weekend}
  EPISODE = %w{mania depression hypomania major\ depression}
  MILDER = %w{hypomania euthymia euthymia depression}

  CSS = %w{yellow blue orange indigo}

  def initialize(symbol); @symbol = symbol; end
  attr_reader :symbol
  alias path :symbol
  alias inspect :symbol

  ALL = SYMBOL.collect {|symbol| self.new symbol}
  SYMBOL.each_with_index do |symbol, index|
    define_singleton_method(symbol) {ALL[index]}
    define_singleton_method(symbol.downcase) {ALL[index]}
  end
  %w{first second third last}.each do |ordinal|
    define_singleton_method(ordinal) {ALL.send(ordinal)}
  end
  def index; SYMBOL.index @symbol; end
  def <=>(other); self.index <=> other.index; end

  class << self
    def all; ALL; end
    def each(&block); ALL.each(&block); end
    def twice; ALL + ALL; end
  end

  constants.each do |constant|
    define_method(constant.downcase) {self.class.const_get(constant)[index]}
  end

  def bipolar; Bipolar.send(symbol.first); end
  def attitude; Attitude.send(symbol); end

  def moon; [phase, 'moon'].to_phrase; end
  def times; [season, moon, week, time]; end
  def seasonal; [season, bipolar.episode].to_phrase; end

  def name; episode.titleize; end
end
