# frozen_string_literal: true

class Attitude < Concept
  SYMBOLS = %i[BL TL TR BR].freeze
  ALL = SYMBOLS.collect { |symbol| new symbol }
  SYMBOLS.each do |sym|
    define_singleton_method(sym) { ALL.find { |s| s.symbol == sym } }
  end

  def self.linear = ALL.values_at(2, 0, 1, 3)

  def top? = string.starts_with?('T')
  def left? = string.ends_with?('L')
  def diagonal? = %i[BL TR].include?(symbol)

  def gu = top? ? 'use' : 'get'
  def es = left? ? 'energy' : 'strength'
  def action = [gu, es].join('_')
  def do_something = [gu, es].to_phrase

  def first_letter = gu.first.capitalize
  def second_letter = es.first.capitalize
  def letters = [first_letter, second_letter].join

  def episode = %w[depression hypomania mania major\ depression][index]
  def size = %w[ fat skinny anorexic  obese][index]
  def mild = %w[restless anxious irritable sick][index]
  def wrong = [size, mild].and
  def feeling = %w[empty afraid angry sore][index]
  def react = %w[digest flee fight rest][index]
  def goal = %w[refuel escape win rebuild][index]

  def element = %w[water air fire earth][index]

  def subtypes = Subtype.all.select { |x| x.attitude == self }
  def +(other) = subtypes.find { |x| x.realm == other }

  def flop = ALL.reverse[index]
  def flip = ALL.values_at(1, 0, 3, 2)[index]
end
