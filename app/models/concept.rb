# frozen_string_literal: true

class Concept
  SYMBOLS = %i[X Y Z].freeze

  def initialize(symbol) = @symbol = symbol
  attr_reader :symbol
  alias inspect :symbol
  def string = symbol.to_s
  alias to_s :string
  alias path :string
  alias link :string

  ALL = SYMBOLS.collect { |symbol| new symbol }
  SYMBOLS.each do |sym|
    define_singleton_method(sym) { ALL.find { |thing| thing.symbol == sym } }
  end

  class << self
    def all = self::ALL
    def [](index) = (all * 2).[](index)
    def find(thing) = all.find { |x| x.symbol == thing.to_sym }
    %i[each each_with_index first second third fourth last without with rotate values_at select].each do |meth|
      delegate meth, to: :all
    end
  end

  def index = self.class::SYMBOLS.index(@symbol)
  def <=>(other) = index <=> other.index

  def ==(other)
    symbol == other.symbol
  end

  def flop = self.class.values_at(3, 2, 1, 0)[index]
  def flip = self.class.values_at(1, 0, 3, 2)[index]
  def base_siblings = [flip, flop]
  def siblings = index.even? ? base_siblings.reverse : base_siblings

  def opposite = (self.class.all + self.class.all)[index + 2]

  # need to define wise in the model
  def title = [string.colon, wise].to_phrase
end
