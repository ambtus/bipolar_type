# frozen_string_literal: true

class Realm < Concept
  SYMBOLS = %i[F S T N].freeze
  ALL = SYMBOLS.collect { |symbol| new symbol }
  SYMBOLS.each do |sym|
    define_singleton_method(sym) { ALL.find { |s| s.symbol == sym } }
  end

  def self.linear = ALL.values_at(1, 3, 0, 2)
  def self.names = linear.map(&:name)
  def self.internals = linear.map(&:internals)
  def self.intakes = linear.map(&:intake)
  def self.externals = all.map(&:externals)
  def self.outputs = all.map(&:output)

  def behaviors = Behavior.all.select { |x| x.realm == self }
  def subtypes = Subtype.all.select { |x| x.realm == self }

  def +(other)
    return behaviors.find { |x| x.attitude == other } if other.is_a? Attitude
    return subtypes.find { |x| x.mood == other } if other.is_a? Mood

    raise "cannot add #{other.class} to realm"
  end

  def adjective = %w[spiritual physical material mental][index]
  def adverb = adjective.ly
  alias realms :adjective
  def definition = adjective.capitalize
  alias name :definition
  alias link :definition

  def intake = %w[listen eat earn look][index]
  def output = %w[talk exercise spend think][index]
  def energy = %w[affect glycogen currency data][index]
  def strength = %w[morals muscles credit rules][index]
  def internals = %w[soul body wallet mind][index]
  def externals = %w[people places things events][index]

  # def reserves = "#{adjective} reserves"
  def reserves = %w[affect weight net-worth memories][index]
  def o_prep = %w[to around on about][index]
  def long_output = [output, o_prep, externals].to_phrase
  def i_prep = (index.zero? ? 'to' : '')
  def long_intake = [intake, i_prep, 'things'].to_phrase

  def ip = (self + Attitude.ip)
  def ep = (self + Attitude.ep)
  def ij = (self + Attitude.ij)
  def ej = (self + Attitude.ej)
end
