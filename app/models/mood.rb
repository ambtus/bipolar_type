# frozen_string_literal: true

class Mood < Concept
  SYMBOLS = %i[p e j i].freeze
  ALL = SYMBOLS.collect { |symbol| new symbol }
  SYMBOLS.each do |sym|
    define_singleton_method(sym) { ALL.find { |s| s.symbol == sym } }
  end

  def self.type_order = ALL.rotate(-1)

  def self.left = ALL.values_at(1, 0, 3, 2)
  def self.right = ALL.rotate

  def actions = Action.all.select { |x| x.string.match string }

  def subtypes = Subtype.all.select { |x| x.string.match string }
  def +(other) = subtypes.find { |x| x.string.match other.string }

  def horizontal? = index.even?

  def location = ['short term', 'external', 'long term', 'internal'][index]
  def focus = %w[urgent tasks important needs][index]
  def generic = [location, focus].to_phrase
end
