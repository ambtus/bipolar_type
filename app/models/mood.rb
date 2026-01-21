# frozen_string_literal: true

class Mood < Concept
  SYMBOLS = %i[i p e j].freeze
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

  def normal = { p: :reactive, e: :brave, j: :proactive, i: :serene }[symbol].to_s
  def episode = { p: :anxiety, e: :mania, j: :irritability, i: :depression }[symbol].to_s

  def title = [string.colon, normal].to_phrase
  def bipolar = [string.colon, episode].to_phrase

  def normality = { p: :perception, e: :courage, j: :control, i: :serenity }[symbol].to_s

end
