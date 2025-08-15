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

  def adjective = %w[spiritual physical material mental][index]
  def adverb = adjective.ly

  def focus = %w[person place thing idea][index]
  def foci = focus.pluralize
  def externals = %w[why land shelter how][index]
  def familiar = %w[family farms hardware software][index]
  def sense = %w[hear smell/taste touch see][index]
  def basic = %w[values food tools implications][index]
  def internals = %w[priorities calories currencies information][index]
  def organ = %w[soul body wallet mind][index]

end
