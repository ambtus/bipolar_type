# frozen_string_literal: true

class Concept
  SYMBOLS = %i[X Y Z].freeze

  def initialize(symbol) = @symbol = symbol
  attr_reader :symbol
  alias inspect :symbol
  def string = symbol.to_s

  ALL = SYMBOLS.collect { |symbol| new symbol }
  SYMBOLS.each do |sym|
    define_singleton_method(sym) { ALL.find { |s| s.symbol == sym } }
  end

  class << self
    def symbols = self::SYMBOLS
    def strings = self::SYMBOLS.map(&:to_s)

    def all = self::ALL
    def values_at(*args) = all.values_at(*args)
    def rotate(i = 1) = all.rotate(i)
    def [](i) = (all * 2).[](i)
    delegate :first, to: :all
    delegate :second, to: :all
    delegate :third, to: :all
    delegate :fourth, to: :all
    delegate :last, to: :all
    def each(&) = all.each(&)
    def each_with_index(&) = all.each_with_index(&)
    def find(s) = all.find { |x| x.symbol == s.to_sym }
    def title = [all.count, name.pluralize].to_phrase
    delegate :without, to: :all
  end

  def index = self.class::SYMBOLS.index(@symbol)

  def next = self.class.rotate[index]
  def previous = self.class.rotate(-1)[index]
  def opposite = self.class.rotate(2)[index]
end
