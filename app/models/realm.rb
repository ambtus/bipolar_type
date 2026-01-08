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

  def self.measurable = [self.S, self.T]
  def self.unmeasurable = [self.N, self.F]

  def generic = %w[physical mental spiritual material][index]
  def jungian = %w[Sensing iNtuition Feeling Thinking][index]
  def focus = %w[food truth love shelter][index]
  def adverb = %w[where how why what][index]
  def internal = %w[body mind soul credit][index]
  def intake = %w[eat watch listen earn][index]
  def intaken = %w[eaten seen heard collected][index]
  def output = %w[move think communicate buy][index]
  def externals = %w[places ideas people things][index]
  def ip = ['eat carbs', 'watch the action', 'listen to music', 'collect wages'][index]
  def ep = ['walk', 'think', 'express emotions', 'pay cash'][index]
  def strength = %w[muscles logic words credit][index]
  def ej = "use #{strength}"
  def ij = ['eat protein', 'watch the results', 'listen to words', 'collect ROI'][index]

  def self.pp_order = ALL.values_at(2, 0, 3, 1)
  def self.focus_order = ALL.values_at(0, 3, 1, 2)
end
