# frozen_string_literal: true

class Mood < Concept
  SYMBOLS = %i[p e j i].freeze
  ALL = SYMBOLS.collect { |symbol| new symbol }
  SYMBOLS.each do |sym|
    define_singleton_method(sym) { ALL.find { |s| s.symbol == sym } }
  end

  def attitudes = Attitude.all.select { |x| x.string.match string }
  def subtypes = Subtype.all.select { |x| x.string.match string }
  def +(other) = subtypes.find { |x| x.string.match other.string }

  def location = %w[left top right bottom][index]
  %w[left top right bottom].each do |meth|
    define_method("#{meth}?") { location == meth }
  end

  def season = %w[spring summer autumn winter][index]
  def nature = %w[energetic empty strong full][index]
  def goal = %w[freedom output control intake][index]

  def self.names = ALL.map(&:nature)
end
