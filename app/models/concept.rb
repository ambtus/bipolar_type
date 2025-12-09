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
    def strings = all.map(&:string)
    def title = [all.count, name.pluralize].to_phrase
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

  def previous = self.class.rotate(-1)[index]
  def next = self.class.rotate[index]
  def opposite = self.class.rotate(2)[index]
  def flop = ALL.reverse[index]
  def flip = ALL.values_at(1, 0, 3, 2)[index]

  def words = File.readlines("words/#{string}", chomp: true)

  def shorts
    result = []
    words.each do |word|
      break if word == ' '

      result << word
    end
    result
  end

  def short_words = shorts.join(' | ')
  def other_words = words - shorts
  def title = [string.colon, short_words].to_phrase
end
