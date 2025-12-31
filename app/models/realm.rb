# frozen_string_literal: true

class Realm < Concept
  SYMBOLS = %i[S N F T].freeze
  ALL = SYMBOLS.collect { |symbol| new symbol }
  SYMBOLS.each do |sym|
    define_singleton_method(sym) { ALL.find { |s| s.symbol == sym } }
  end

  def behaviors = Behavior.all.select { |x| x.realm == self }
  def subtypes = Subtype.all.select { |x| x.realm == self }

  def +(other)
    return behaviors.find { |x| x.action == other } if other.is_a? Action

    subtypes.find { |x| x.mood == other }
  end

  def generic = %w[physical mental social financial][index]
  def internal = %w[body mind voice credit][index]
  def intake = %w[eat watch listen earn][index]
  def intaken = %w[eaten seen heard collected][index]
  def output = %w[move think talk spend][index]
  def externals = %w[places ideas people tools][index]
  def refuel = ['eat in', 'learn from', 'listen to', 'earn using'][index]
  def rest = ['rest in', 'rest with', 'rest with', 'rest using using'][index]

  def self.pp_order = ALL.values_at(2, 0, 3, 1)
end
