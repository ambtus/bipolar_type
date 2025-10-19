# frozen_string_literal: true

class Concept

  SYMBOLS = %i[X Y Z].freeze

  def initialize(symbol) = @symbol = symbol
  attr_reader :symbol
  alias inspect :symbol
  def string = symbol.to_s
  alias to_s :string
  alias title :string
  alias link :string
  alias path :string

  ALL = SYMBOLS.collect { |symbol| new symbol }
  SYMBOLS.each do |sym|
    define_singleton_method(sym) { ALL.find { |thing| thing.symbol == sym } }
  end

  class << self
    def symbols = self::SYMBOLS
    def strings = self::SYMBOLS.map(&:to_s)

    def all = self::ALL
    def values_at(*args) = all.values_at(*args)
    def rotate(index = 1) = all.rotate(index)
    def [](index) = (all * 2).[](index)
    delegate :first, to: :all
    delegate :second, to: :all
    delegate :third, to: :all
    delegate :fourth, to: :all
    delegate :last, to: :all
    def each(&) = all.each(&)
    def each_with_index(&) = all.each_with_index(&)
    def find(thing) = all.find { |x| x.symbol == thing.to_sym }
    def title = [all.count, name.pluralize].to_phrase
    delegate :without, to: :all
  end

  def index = self.class::SYMBOLS.index(@symbol)

  def first? = index.zero?
  def second? = (index == 1)
  def third? = (index == 2)
  def last? = (index == 3)

  def <=>(other) = index <=> other.index

  def next = self.class.rotate[index]
  def previous = self.class.rotate(-1)[index]
  def opposite = self.class.rotate(2)[index]
  def flop = ALL.reverse[index]
  def flip = ALL.values_at(1, 0, 3, 2)[index]

end
