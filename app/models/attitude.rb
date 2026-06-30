# frozen_string_literal: true

class Attitude < Concept
  SYMBOLS = %i[i e f o].freeze
  ALL = SYMBOLS.collect { |symbol| new symbol }
  SYMBOLS.each do |sym|
    define_singleton_method(sym) { ALL.find { |s| s.symbol == sym } }
  end

  def self.linear = ALL.values_at(0, 1, 3, 2)

  def mild = %w[unwell stressed restless fat][index]
  def severe = %w[ill strained anxious obese][index]
  def result = %w[illness strain insomnia obesity][index]
  def name = result.capitalize

  def behaviors = Behavior.all.select { |x| x.attitude == self }
  def +(other) = behaviors.find { |x| x.realm == other }

end
