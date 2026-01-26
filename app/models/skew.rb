# frozen_string_literal: true

class Skew < Concept
  SYMBOLS = %i[↻ ↺].freeze
  ALL = SYMBOLS.collect { |symbol| new symbol }
  SYMBOLS.each do |sym|
    define_singleton_method(sym) { ALL.find { |s| s.symbol == sym } }
  end

  def self.mine = Skew.first

  def clockwise? = symbol == :↺

  def other = Skew.without(self).first
end
