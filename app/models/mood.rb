# frozen_string_literal: true

class Mood < Concept
  SYMBOLS = %i[p e j i].freeze
  ALL = SYMBOLS.collect { |symbol| new symbol }
  SYMBOLS.each do |sym|
    define_singleton_method(sym) { ALL.find { |s| s.symbol == sym } }
  end

  def subtypes = Subtype.all.select { |x| x.string.match string }
  def +(other) = subtypes.find { |x| x.string.match other.string }

  def rather = %w[ep output ej intake][index]

  def name = %w[prey mania predator depression][index]

  def neutral = %w[agile high powerful down][index]
  def bad = %w[young stressed old bored][index]

  def season = %w[spring summer autumn winter][index]
  def good = %w[playful active responsible receptive][index]
  def goal = %w[freedom change control acceptance][index]

  def description = [good, goal].to_phrase
  alias mood :description
  def balance = %w[energy output strength intake][index]

  def self.names = ALL.map(&:name)
end
