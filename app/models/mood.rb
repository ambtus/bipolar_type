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

  FEELINGS = { p: :afraid, e: :angry, j: 'safe', i: 'low on fuel' }.freeze
  def wise = FEELINGS[symbol].to_s

  EPISODES = { p: :anxiety, e: :mania, j: :irritability, i: :depression }.freeze
  def episode = EPISODES[symbol].to_s

  EMOTIONS = { p: 'anxious<br />(learned fear)', e: 'irritable<br />(learned anger)', j: 'out of energy', i: 'out of strength' }.freeze
  def foolish = EMOTIONS[symbol].to_s

  def bipolar = "#{string}: #{foolish}".html_safe
end
