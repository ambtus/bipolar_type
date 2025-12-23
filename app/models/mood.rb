# frozen_string_literal: true

class Mood < Concept
  SYMBOLS = %i[p e j i].freeze
  ALL = SYMBOLS.collect { |symbol| new symbol }
  SYMBOLS.each do |sym|
    define_singleton_method(sym) { ALL.find { |s| s.symbol == sym } }
  end

  def self.bp1 = ALL.values_at(1,0,3,2)
  def self.bp2 = ALL.values_at(1,2,3,0)

  def actions = Action.all.select { |x| x.string.match string }

  def subtypes = Subtype.all.select { |x| x.string.match string }
  def +(other) = subtypes.find { |x| x.string.match other.string }

  def horizontal? = index.even?
  def vertical? = index.odd?

  def episode = %w[energy output strength intake][index]

end
