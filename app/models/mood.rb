# frozen_string_literal: true

class Mood < Concept
  SYMBOLS = %i[p e j i].freeze
  ALL = SYMBOLS.collect { |symbol| new symbol }
  SYMBOLS.each do |sym|
    define_singleton_method(sym) { ALL.find { |s| s.symbol == sym } }
  end

  def self.nature_order = ALL.rotate(-1)

  def self.bp1 = ALL.values_at(1, 0, 3, 2)
  def self.bp2 = ALL.rotate

  def actions = Action.all.select { |x| x.string.match string }

  def subtypes = Subtype.all.select { |x| x.string.match string }
  def +(other) = subtypes.find { |x| x.string.match other.string }

  def horizontal? = index.even?

  def adjective = ['short term', 'external', 'long term', 'internal'][index]
  def generic = [adjective, 'focus'].to_phrase
end
