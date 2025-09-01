# frozen_string_literal: true

class Attitude < Concept
  SYMBOLS = %i[ip ep ej ij].freeze
  ALL = SYMBOLS.collect { |symbol| new symbol }
  SYMBOLS.each do |sym|
    define_singleton_method(sym) { ALL.find { |s| s.symbol == sym } }
  end

  LINEAR = [3, 0, 1, 2].freeze
  def self.linear = ALL.values_at(*LINEAR)

  def top? = string.starts_with?('e')
  def left? = string.ends_with?('p')

  def execute = top? ? 'externalize' : 'internalize'
  def which = left? ? 'energy' : 'strength'
  def do_something = [execute, which].to_phrase

  def self.tops = ALL.select(&:top?)
  def bottom? = string.starts_with?('i')
  def self.bottoms = ALL.select(&:bottom?)

  def first? = index.zero?
  def second? = (index == 1)
  def third? = (index == 2)
  def last? = (index == 3)

  def react = %w[digest flee fight rest][index]
  def goal = %w[refuel escape win recover][index]

  def bad = %w[hungry anxious irritable tired][index]
  def worse = %w[starving afraid angry exhausted][index]

  def time_of_day = %w[morning midday afternoon evening][index]
  def time = second? ? "at #{time_of_day}" : "in the #{time_of_day}"
  def season = %w[winter/spring spring/summer summer/autumn autumn/winter][index]
  def bipolar = top? ? 'mania' : 'depression'
  def seasonal = flop.season
  def episode = [flop.bad, bipolar].to_phrase.titleize
  def stop = [react, goal].and

  def behaviors = Behavior.all.select { |x| x.attitude == self }
  def +(other) = behaviors.find { |x| x.realm == other }

  def flop = ALL.reverse[index]
  def flip = ALL.values_at(1, 0, 3, 2)[index]
end
