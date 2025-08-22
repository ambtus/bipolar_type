# frozen_string_literal: true

class Attitude < Concept
  SYMBOLS = %i[BL TL TR BR].freeze
  ALL = SYMBOLS.collect { |symbol| new symbol }
  SYMBOLS.each do |sym|
    define_singleton_method(sym) { ALL.find { |s| s.symbol == sym } }
  end

  LINEAR = [3, 0, 1, 2].freeze
  def self.linear = ALL.values_at(*LINEAR)

  def top? = string.starts_with?('T')
  def self.tops = ALL.select(&:top?)
  def bottom? = string.starts_with?('B')
  def self.bottoms = ALL.select(&:bottom?)

  def left? = string.ends_with?('L')
  def diagonal? = [1, 3].include?(index)
  def first? = index.zero?
  def second? = (index == 1)
  def third? = (index == 2)
  def last? = (index == 3)

  def react = %w[digest flee fight rest][index]
  def goal = %w[refuel escape control rebuild][index]

  def bad = %w[drained anxious irritated tired][index]
  def worse = %w[empty afraid angry exhausted][index]

  def time_of_day = %w[morning midday afternoon evening][index]
  def time = second? ? "at #{time_of_day}" : "in the #{time_of_day}"
  def season = %w[winter/spring spring/summer summer/autumn autumn/winter][index]
  def bipolar = top? ? 'mania' : 'depression'
  def seasonal = flop.season
  def episode = [seasonal, bipolar].to_phrase.titleize

  def behaviors = Behavior.all.select { |x| x.attitude == self }
  def +(other) = behaviors.find { |x| x.realm == other }

  def flop = ALL.reverse[index]
  def flip = ALL.values_at(1, 0, 3, 2)[index]
end
