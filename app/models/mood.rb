# frozen_string_literal: true

class Mood < Concept
  SYMBOLS = %i[p e j i].freeze
  ALL = SYMBOLS.collect { |symbol| new symbol }
  SYMBOLS.each do |sym|
    define_singleton_method(sym) { ALL.find { |s| s.symbol == sym } }
  end

  def actions = Action.all.select { |x| x.string.match string }

  def subtypes = Subtype.all.select { |x| x.string.match string }
  def +(other) = subtypes.find { |x| x.string.match other.string }

  def horizontal? = index.even?

  def mood = %w[anxiety mania irritability depression][index]
  def normal = %w[urgent awake important asleep][index]

  def bipolar = [string.colon, mood].to_phrase
end
