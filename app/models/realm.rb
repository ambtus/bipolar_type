# frozen_string_literal: true

class Realm < Concept
  SYMBOLS = %i[F S T N].freeze
  ALL = SYMBOLS.collect { |symbol| new symbol }
  SYMBOLS.each do |sym|
    define_singleton_method(sym) { ALL.find { |s| s.symbol == sym } }
  end

  def self.linear = ALL.values_at(1, 3, 2, 0)
  def self.names = linear.map(&:name)

  def behaviors = Behavior.all.select { |x| x.realm == self }
  def subtypes = Subtype.all.select { |x| x.realm == self }

  def +(other)
    return behaviors.find { |x| x.attitude == other } if other.is_a? Attitude
    return subtypes.find { |x| x.mood == other } if other.is_a? Mood

    raise "cannot add #{other.class} to realm"
  end

  def externalize = behaviors.select(&:top?).map(&:words)
  def internalize = behaviors.select(&:bottom?).map(&:words)
  def be_energetic = behaviors.select(&:left?).map(&:words)
  def be_strong = behaviors.select(&:right?).map(&:words)

  def adjective = %w[spiritual physical material mental][index]
  def adverb = adjective.ly
  alias name :adjective
  alias realms :name

  # def reserves = "#{adjective} reserves"
  def reserves = %w[affect weight net-worth memories][index]
  def internals = %w[soul body wallet mind][index]
  def externals = %w[people places tools ideas][index]
  def output = %w[talk move spend think][index]
  def o_prep = %w[to around on about][index]
  def long_output = [output, o_prep, externals].to_phrase
  def intake = ip.words.first
  def i_prep = (index.zero? ? 'to' : '')
  def long_intake = [intake, i_prep, 'things'].to_phrase
  def energy = %w[emotions calories money information][index]

  def ip = (self + Attitude.ip).words
  def ep = (self + Attitude.ep).words
  def ij = (self + Attitude.ij).words
  def ej = (self + Attitude.ej).words
end
