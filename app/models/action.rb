# frozen_string_literal: true

class Action < Concept
  SYMBOLS = %i[ip ep ej ij].freeze
  ALL = SYMBOLS.collect { |symbol| new symbol }
  SYMBOLS.each do |sym|
    define_singleton_method(sym) { ALL.find { |s| s.symbol == sym } }
  end

  def behaviors = Behavior.all.select { |x| x.action == self }
  def +(other) = behaviors.find { |x| x.realm == other }

  def opposite = (ALL + ALL)[index + 2]

  def flop = ALL.values_at(3, 2, 1, 0)[index]
  def flip = ALL.values_at(1, 0, 3, 2)[index]

  def siblings = [flop, self, flip]

  def moods = string.chars.collect{|x| Mood.find(x)}

  ACTIONS = { ip: :refuel, ep: :flee, ej: :fight, ij: :rest }.freeze
  def wise = ACTIONS[symbol].to_s
  def episode = "#{wise} when you should be #{flop.wise.ing}"

  EPISODES = { ip: :depression, ep: :mania, ej: :hypomania, ij: :dysthymia }.freeze
  def skew = EPISODES[symbol].to_s
  def bipolar = "#{string}: #{skew}"
end
