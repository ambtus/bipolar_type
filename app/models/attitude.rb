# frozen_string_literal: true

class Attitude < Concept
  SYMBOLS = %i[BL TL TR BR].freeze
  ALL = SYMBOLS.collect { |symbol| new symbol }
  SYMBOLS.each do |sym|
    define_singleton_method(sym) { ALL.find { |s| s.symbol == sym } }
  end

  def self.ordered = ALL.values_at(1,0,3,2)

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

  def feeling = %w[empty afraid angry sore][index]
  def react = %w[digest flee fight rest][index]
  def act = %w[ingest move work sleep][index]
  def goal = %w[refuel escape control rebuild][index]

  def sick = top? ? 'manic' : 'depressed'

  def subtypes = Subtype.all.select { |x| x.attitude == self }
  def +(other) = subtypes.find { |x| x.realm == other }
end
