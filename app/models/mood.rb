# frozen_string_literal: true

class Mood < Concept
  SO = [1, 3, 0, 2].freeze
  SYMBOLS = %i[p e j i].freeze
  ALL = SYMBOLS.collect { |symbol| new symbol }
  SYMBOLS.each do |sym|
    define_singleton_method(sym) { ALL.find { |s| s.symbol == sym } }
  end

  def self.subtype_order = ALL.values_at(*SO)

  def actions = Action.all.select { |x| x.string.match string }

  def subtypes = Subtype.all.select { |x| x.string.match string }
  def +(other) = subtypes.find { |x| x.string.match other.string }

  def horizontal? = index.even?
  def vertical? = index.odd?

  def episode = %w[anxious mania irritable depression][index]
end
