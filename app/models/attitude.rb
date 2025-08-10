# frozen_string_literal: true

class Attitude < Concept
  SYMBOLS = %i[BL TL TR BR].freeze
  ALL = SYMBOLS.collect { |symbol| new symbol }
  SYMBOLS.each do |sym|
    define_singleton_method(sym) { ALL.find { |s| s.symbol == sym } }
  end

  LINEAR = [2, 1, 0, 3].freeze

  def self.linear = ALL.values_at(*LINEAR)

  def top? = string.starts_with?('T')
  def left? = string.ends_with?('L')
  def diagonal? = [1, 3].include?(index)
  def first? = index.zero?
  def second? = (index == 1)
  def last? = (index == 3)

  def react = %w[digest flee fight rest][index]
  def reaction = %w[digestion flight fight rest][index]
  def goal = %w[refuel escape dominate rebuild][index]

  def bad = ['low on energy', 'anxious', 'irritated', 'tired'][index]
  def badness = %w[depression anxiety irritation tiredness][index]
  def worse = %w[empty afraid angry exhausted][index]

  def element = %w[water air fire earth][index]
  def time = %w[morning midday afternoon evening][index]
  def season = %w[spring summer autumn winter][index]

  def subtypes = Subtype.all.select { |x| x.attitude == self }
  def +(other) = subtypes.find { |x| x.realm == other }

  def flop = ALL.reverse[index]
  def flip = ALL.values_at(1, 0, 3, 2)[index]
end
