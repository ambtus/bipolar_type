class State

  SYMBOL = %w{I E}
  STATE = %w{alert calm}
  PHRASE = %w{fight/flight rest/digest}
  VERB = %w{externalize internalize}
  NOUN = %w{output intake}
  NAME = %w{mania depression}
  MILD = %w{restless relaxed}
  SEVERE = %w{stressed bored}
  CHANGE = %w{lose_reserves gain_reserves}
  ADJECTIVE = %w{productive receptive}
  TRIGGER = %w{changes stability}
  SPEED = %w{fast slow}
  STATUS = %w{active passive}
  SENSITIVITY = %w{sensitive stolid}
  TEMPERATURE = %w{hot cold}

  def initialize(symbol); @symbol = symbol; end
  attr_reader :symbol
  alias path :symbol
  alias inspect :symbol

  ALL = SYMBOL.collect {|symbol| self.new symbol}
  SYMBOL.each_with_index do |symbol, index|
    define_singleton_method(symbol) {ALL[index]}
    define_singleton_method(symbol.downcase) {ALL[index]}
  end
  def index; SYMBOL.index @symbol; end
  def <=>(other); self.index <=> other.index; end

  class << self
    def all; ALL; end
    def each(&block); ALL.each(&block); end
    def visible; constants - %i{ALL SYMBOL NAME}; end
    def first; ALL.first; end
    def second; ALL.second; end
    def cookies; ALL.map(&:cookie); end
  end

  def flip; ALL.without(self).first; end
  def flop; self; end
  def opposite; flip.flop; end

  constants.each do |constant|
    define_method(constant.downcase) {self.class.const_get(constant)[index]}
  end
  alias css :name
  alias cookie :symbol

  def feelings; [mild, severe].or; end
  def sick; name.to_adjective; end

  def phases; Phase.all.select{|p| p.bipolar == self}; end

end
