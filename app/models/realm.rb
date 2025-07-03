# frozen_string_literal: true

class Realm < Concept
  SYMBOLS = %i[F S N T].freeze
  ALL = SYMBOLS.collect { |symbol| new symbol }
  SYMBOLS.each do |sym|
    define_singleton_method(sym) { ALL.find { |s| s.symbol == sym } }
  end

  def subtypes = Subtype.all.select { |x| x.realm == self }
  def +(other) = subtypes.find { |x| x.attitude == other }

  def focus = %w[person place idea thing][index]
  def foci = focus.pluralize
  def name = foci.capitalize

  def empty = %w[lonely hungry curious envious][index]
  def organ = %w[soul body mind wallet][index]

  def adjective = %w[social physical mental financial][index]
  def adverb = adjective.ly
  def letter = adjective.first.capitalize

  def get = ['listen to', 'eat', 'watch', 'collect'][index]
  def energy = ['music', 'carbs', 'the sunrise', 'wages'][index]
  def strength = ['stories', 'protein', 'the results', 'dividends'][index]
  def get_energy = [get, energy].to_phrase
  def recover_strength = [get, strength].to_phrase
  def burn_energy = ['talk', 'walk', 'use intuition', 'pay cash'][index]
  def use_strength = ['write', 'do housework', 'use logic', 'use credit'][index]
end
