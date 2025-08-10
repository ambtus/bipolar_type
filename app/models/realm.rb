# frozen_string_literal: true

class Realm < Concept
  SYMBOLS = %i[F S T N].freeze
  ALL = SYMBOLS.collect { |symbol| new symbol }
  SYMBOLS.each do |sym|
    define_singleton_method(sym) { ALL.find { |s| s.symbol == sym } }
  end

  def self.linear = ALL.values_at(1, 2, 3, 0)

  def subtypes = Subtype.all.select { |x| x.realm == self }
  def +(other) = subtypes.find { |x| x.attitude == other }

  def tops = subtypes[1, 2]
  def bottoms = subtypes.values_at(0, 3)

  def focus = %w[person place thing idea][index]
  def foci = focus.pluralize
  def basic = %w[why food shelter how][index]
  def organ = %w[soul body wallet mind][index]
  def sense = %w[hear smell/taste touch see][index]
  def resources = %w[priorities calories money information][index]
  def products = %w[values farms uses implications][index]
  def target = %w[family land hardware software][index]
  def adj1 = %w[spiritual physical material mental][index]
  def adj2 = %w[emotional spatial financial temporal][index]
  alias adjective :adj1
  def adverb = adjective.ly
  def name = adjective.capitalize

  # def adjective =%w[emotional physical financial mental][index]
  def letter = %w[E P F M][index]
end
