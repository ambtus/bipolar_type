# frozen_string_literal: true

class Mood < Concept
  SYMBOLS = %i[p e j i].freeze
  ALL = SYMBOLS.collect { |symbol| new symbol }
  SYMBOLS.each do |sym|
    define_singleton_method(sym) { ALL.find { |s| s.symbol == sym } }
  end

  def actions = Action.all.select { |x| x.string.match string }

  def reverse? = symbol == :i
  def sibling_actions = reverse? ? actions.reverse : actions

  def subtypes = Subtype.all.select { |x| x.string.match string }
  def +(other) = subtypes.find { |x| x.string.match other.string }

  def horizontal? = %i[p j].include?(symbol)

  def wise = { p: :afraid, e: :angry, j: :tired, i: 'low on fuel' }[symbol].to_s

  def foolish = { p: :anxiety, e: :mania, j: :irritability, i: :depression }[symbol].to_s

end
