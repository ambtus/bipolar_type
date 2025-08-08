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
  def diagonal? = %i[BL TR].include?(symbol)

  def gu = top? ? 'use' : 'get'
  def es = left? ? 'energy' : 'strength'
  def do_something = [gu, es].to_phrase

  def first_letter = top? ? 'U' : 'G'
  def second_letter = left? ? 'E' : 'S'

  def size = %w[fat skinny anorexic obese][index]

  def feeling = %w[empty afraid angry sore][index]
  def react = %w[digest flee fight rest][index]
  def reaction = %w[digestion flight fight rest][index]
  def goal = %w[refuel escape win rebuild][index]

  def element = %w[water air fire earth][index]
  def time = %w[morning midday afternoon evening][index]

  def subtypes = Subtype.all.select { |x| x.attitude == self }
  def +(other) = subtypes.find { |x| x.realm == other }

  def flop = ALL.reverse[index]
  def flip = ALL.values_at(1, 0, 3, 2)[index]
end
