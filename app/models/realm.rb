# frozen_string_literal: true

class Realm < Concept
  SYMBOLS = %i[F S T N].freeze
  ALL = SYMBOLS.collect { |symbol| new symbol }
  SYMBOLS.each do |sym|
    define_singleton_method(sym) { ALL.find { |s| s.symbol == sym } }
  end

  def self.linear = ALL.values_at(1, 3, 0, 2)

  def subtypes = Subtype.all.select { |x| x.realm == self }
  def +(other) = subtypes.find { |x| x.attitude == other }

  def tops = subtypes[1, 2]
  def bottoms = subtypes.values_at(0, 3)

  def focus = %w[person place thing idea][index]
  def foci = focus.pluralize

  def basic = %w[why food shelter how][index]
  def name = basic.capitalize

  def organ = %w[voice body wallet mind][index]
  def organly = %w[vocally bodily financially mentally][index]
  def sense = %w[hearing smell/taste touch sight][index]
  def resources = %w[priorities calories money information][index]
  def products = %w[values foods uses implications][index]
  def target = %w[family land hardware software][index]
  def adj1 = %w[spiritual physical material mental][index]
  def adj2 = %w[emotional spatial financial temporal][index]
  def adjective =%w[emotional physical financial mental][index]
  def adverb = adjective.ly

  def letter = %w[E P F M][index]

  def get = ['listen to', 'eat', 'earn', 'memorize'][index]
  def energy = %w[music carbs wages specifics][index]
  def strength = %w[sermons protein a\ salary rules][index]
  def get_energy = [get, energy].to_phrase
  def get_strength = [get, strength].to_phrase
  def use_energy = ['sing', 'run', 'pay cash', 'guess'][index]
  def use_strength = ['preach', 'do housework', 'use credit', 'use logic'][index]
end
