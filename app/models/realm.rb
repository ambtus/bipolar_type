# frozen_string_literal: true

class Realm < Concept
  SYMBOLS = %i[F S T N].freeze
  ALL = SYMBOLS.collect { |symbol| new symbol }
  SYMBOLS.each do |sym|
    define_singleton_method(sym) { ALL.find { |s| s.symbol == sym } }
  end

  def subtypes = Subtype.all.select { |x| x.realm == self }
  def +(other) = subtypes.find { |x| x.attitude == other }

  def tops = subtypes[1, 2]
  def bottoms = subtypes.values_at(0, 3)

  def focus = %w[person place thing idea][index]
  def foci = focus.pluralize

  def basic = %w[why food shelter how][index]
  def name = basic.capitalize

  def organ = %w[voice body hands mind][index]
  def sense = %w[hearing smell/taste touch sight][index]
  def resources = %w[priorities calories tools data][index]
  def target = %w[family land hardware software][index]
  def adj1 = %w[spiritual physical material mental][index]
  def adj2 = %w[emotional spatial financial temporal][index]
  def adjective =%w[emotional physical financial mental][index]
  def adverb = adjective.ly

  def letter = %w[E P F M][index]

  def get = ['listen to', 'eat', 'earn', 'see'][index]
  def energy = %w[music carbs cash actions][index]
  def strength = %w[words protein credit results][index]
  def get_energy = [get, energy].to_phrase
  def get_strength = [get, strength].to_phrase
  def use_energy = ['sing', 'gather', 'pay cash', 'intuit'][index]
  def use_strength = ['use words', 'hunt', 'use credit', 'use logic'][index]
end
