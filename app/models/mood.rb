# frozen_string_literal: true

class Mood < Concept
  SYMBOLS = %i[p e j i].freeze
  ALL = SYMBOLS.collect { |symbol| new symbol }
  SYMBOLS.each do |sym|
    define_singleton_method(sym) { ALL.find { |s| s.symbol == sym } }
  end

  def opposite = (ALL + ALL)[index + 2]

  def siblings = ALL - [self, opposite]

  def actions = Action.all.select { |x| x.string.match string }

  def reverse? = symbol == :i
  def sibling_actions = reverse? ? actions.reverse : actions

  def subtypes = Subtype.all.select { |x| x.string.match string }
  def +(other) = subtypes.find { |x| x.string.match other.string }

  def horizontal? = %i[p j].include?(symbol)

  STATES = { p: :afraid, e: :brave, j: :pleased, i: :serene }.freeze
  EPISODES = { p: :anxious, e: :manic, j: :tired, i: :depressed }.freeze

  def wise = STATES[symbol].to_s
  def foolish = EPISODES[symbol].to_s

  def bipolar = "#{string}: #{foolish}"
end
