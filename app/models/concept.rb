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
    %i[each each_with_index first second third fourth last without rotate values_at select].each do |meth|
      delegate meth, to: :all
    end
  end

  def index = self.class::SYMBOLS.index(@symbol)
  def <=>(other) = index <=> other.index

  def ==(other)
    symbol == other.symbol
  end

  def wise = string # for now. make it a hash later in the model
  def title = [string.colon, wise].to_phrase

end
