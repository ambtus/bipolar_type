# frozen_string_literal: true

class Basic < Concept
  SYMBOLS = %i[e i].freeze
  ALL = SYMBOLS.collect { |symbol| new symbol }
  SYMBOLS.each do |sym|
    define_singleton_method(sym) { ALL.find { |s| s.symbol == sym } }
  end

  def self.mine = Basic.i

  def e? = index.zero?

  def other = e? ? Basic.i : Basic.e
  alias extroverted? e?

  def first_color = e? ? 'red' : 'green'
  def second_color = other.first_color
end
