# frozen_string_literal: true

class Attitude < Concept
  SYMBOLS = %i[i e f o].freeze
  ALL = SYMBOLS.collect { |symbol| new symbol }
  SYMBOLS.each do |sym|
    define_singleton_method(sym) { ALL.find { |s| s.symbol == sym } }
  end

  def self.linear = ALL.values_at(0, 1, 3, 2)

  def mild = %w[sick thin anxious fat][index]
  def severe = %w[ill emaciated afraid obese][index]
  def result = %w[illness emaciation fear obesity][index]
  def name = result.capitalize

  def behaviors = Behavior.all.select { |x| x.attitude == self }
  def +(other) = behaviors.find { |x| x.realm == other }

end
