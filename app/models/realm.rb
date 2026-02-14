# frozen_string_literal: true

class Realm < Concept
  SYMBOLS = %i[ S N F T ].freeze
  ALL = SYMBOLS.collect { |symbol| new symbol }
  SYMBOLS.each do |sym|
    define_singleton_method(sym) { ALL.find { |s| s.symbol == sym } }
  end

  def self.mine = [Realm.F, Realm.T, Realm.N, Realm.S]


  def name = { F: :social, T: :financial, S: :physical, N: :mental }[symbol].to_s
  def adverb = name.ly

  def aspect = { F: :soul, T: :hands, S: :body, N: :mind}[symbol].to_s
  alias_method :i, :aspect

  def targets = { F: :opinions, T: :tools, S: :foods, N: :ideas}[symbol].to_s
  alias_method :e, :targets

  def energy = { F: :emotions, T: :cash, S: :calories, N: :specifics}[symbol].to_s
  alias_method :p, :energy

  def strength = { F: :words, T: :credit, S: :muscles, N: :rules}[symbol].to_s
  alias_method :j, :strength

  def fuel = { F: 'listen to music', S: 'eat breakfast carbs', N: 'analyze the news', T: 'earn spending money'}[symbol]
  alias_method :f, :fuel

  def explore = { F: 'tell new people', S: 'go new places', N: 'make new plans', T: 'buy new tools'}[symbol]
  alias_method :x, :explore

  def control = { F: 'teach or preach', S: 'cook or clean', N: 'theorize or hypothesize', T: 'build or invest'}[symbol]
  alias_method :c, :control

  def rest = { F: 'listen to stories', S: 'eat dinner proteins', N: 'analyze the results', T: 'earn repayments'}[symbol]
  alias_method :r, :rest

end
