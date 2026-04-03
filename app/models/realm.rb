# frozen_string_literal: true

class Realm < Concept
  SYMBOLS = %i[ S N F T ].freeze
  ALL = SYMBOLS.collect { |symbol| new symbol }
  SYMBOLS.each do |sym|
    define_singleton_method(sym) { ALL.find { |s| s.symbol == sym } }
  end

  def self.mine = [Realm.F, Realm.T, Realm.S, Realm.N]

  def +(behavior) = Subtype.all.find {|s| s.realm == self && s.behavior == behavior}

  def adjective = { F: :social, T: :financial, S: :physical, N: :mental }[symbol].to_s
  def adverb = adjective.ly

  def name = { F: :soul, T: :wallet, S: :body, N: :mind}[symbol].to_s
  alias_method :i, :name

  def targets = { F: :opinions, T: :tools, S: :foods, N: :ideas}[symbol].to_s
  alias_method :e, :targets

  def energy = { F: :vaues, T: :money, S: :calories, N: :memories}[symbol].to_s
  alias_method :p, :energy

  def strength = { F: :words, T: :credit, S: :muscles, N: :logic}[symbol].to_s
  alias_method :j, :strength

  def intake = { F: :listen, S: :eat, N: :watch, T: :earn}[symbol].to_s
  def output = { F: :talk, S: :move, N: :think, T: :spend}[symbol].to_s


  def fuel = { F: 'listen to music', S: 'eat breakfast carbs', N: 'analyze the facts', T: 'earn spending money'}[symbol]
  alias_method :f, :fuel
  alias_method :ip, :fuel

  def explore = { F: 'tell new people', S: 'go new places', N: 'paint new pictures', T: 'buy new toys'}[symbol]
  alias_method :x, :explore
  alias_method :ep, :explore

  def control = { F: 'teach or preach', S: 'cook or clean', N: 'theorize or hypothesize', T: 'build or invest'}[symbol]
  alias_method :c, :control
  alias_method :ej, :control

  def rest = { F: 'listen to stories', S: 'eat dinner proteins', N: 'follow the rules', T: 'earn repayments'}[symbol]
  alias_method :r, :rest
  alias_method :ij, :rest

end
