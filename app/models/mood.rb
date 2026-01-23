# frozen_string_literal: true

class Mood < Concept
  SYMBOLS = %i[p e j i].freeze
  ALL = SYMBOLS.collect { |symbol| new symbol }
  SYMBOLS.each do |sym|
    define_singleton_method(sym) { ALL.find { |s| s.symbol == sym } }
  end

  def opposite = (ALL+ALL)[index + 2]

  def actions = Action.all.select { |x| x.string.match string }

  def reverse? = symbol == :i
  def sibling_actions = reverse? ? actions.reverse : actions

  def subtypes = Subtype.all.select { |x| x.string.match string }
  def +(other) = subtypes.find { |x| x.string.match other.string }

  def horizontal? = %i[p j].include?(symbol)

  def foolish = { p: :ashamed, e: :manic, j: :miserable, i: :depressed }[symbol].to_s
  def foolishness = { p: :shame, e: :mania, j: :misery, i: :depression }[symbol].to_s
  def bipolar = [string.colon, foolish].to_phrase

  def wise = { p: :happy, e: :brave, j: :proud, i: :serene }[symbol].to_s
  def wisdom = { p: :happiness, e: :courage, j: :pride, i: :serenity }[symbol].to_s
end
