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
  alias top :foci

  def unfamiliar = %w[friends land machines procedures][index]
  def familiar = %w[family farms hardware software][index]
  def give = %w[tell feed build show][index]
  def externals = %w[why food shelter how][index]
  def sense = %w[hear smell/taste touch see][index]
  def take =%w[ears nose/mouth wallet eyes][index]
  def basic = %w[stories meals tools signs][index]
  def internals = %w[morals calories value information][index]
  def neuro = %w[oxytocin serotonin dopamine glutamate][index]
  def organ = %w[soul body hands mind][index]
  alias bottom :organ
  def left = %w[expressive gather labor tactics][index]
  def right = %w[lexical hunt capital logistics][index]
end
