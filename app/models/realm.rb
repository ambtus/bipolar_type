# frozen_string_literal: true

class Realm < Concept
  SYMBOLS = %i[F S T N].freeze
  ALL = SYMBOLS.collect { |symbol| new symbol }
  SYMBOLS.each do |sym|
    define_singleton_method(sym) { ALL.find { |s| s.symbol == sym } }
  end

  def self.linear = ALL.values_at(1, 2, 3, 0)

  def behaviors = Behavior.all.select { |x| x.realm == self }
  def +(other) = behaviors.find { |x| x.attitude == other }

  def focus = %w[person place thing idea][index]
  def foci = focus.pluralize
  def basic = %w[why food shelter how][index]
  def organ = %w[soul body wallet mind][index]
  def sense = %w[hear smell/taste touch see][index]
  def resources = %w[priorities calories money information][index]
  def products = %w[values land tools implications][index]
  def target = %w[family farms hardware software][index]
  def adj1 = %w[spiritual physical material mental][index]
  def adj2 = %w[emotional spatial financial temporal][index]
  def adjective = %w[emotional physical financial mental][index]
  def letter = %w[E P F M][index]
  def adverb = adjective.ly
end
