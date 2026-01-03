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

  def title = [string.colon, generic].to_phrase

  def generic = %w[physical mental spiritual material][index]
  def internal = %w[body mind voice credit][index]
  def intake = %w[eat watch listen earn][index]
  def intaken = %w[eaten seen heard collected][index]
  def output = %w[move think communicate buy][index]
  def externals = %w[places ideas people tools][index]
  def refuel = ['eat in', 'learn from', 'listen to', 'earn using'][index]
  def rest = ['rest in', 'rest with', 'rest with', 'rest using using'][index]

  def get_energy = ['eat carbs', 'research facts', 'listen to music', 'collect wages'][index]
  def burn_energy = ['walk', 'guess', 'cry', 'spend cash'][index]
  def strength = %w[ muscles logic words credit][index]
  def use_strength = "use #{strength}"
  def rebuild_strength = ['eat protein', 'watch the results', 'listen to words', 'collect a stable income'][index]

  def self.pp_order = ALL.values_at(2, 0, 3, 1)
end
