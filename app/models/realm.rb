# frozen_string_literal: true

class Realm < Concept
  SYMBOLS = %i[e p f m].freeze
  ALL = SYMBOLS.collect { |symbol| new symbol }
  SYMBOLS.each do |sym|
    define_singleton_method(sym) { ALL.find { |s| s.symbol == sym } }
  end

  def self.mine = ALL.values_at(0, 2, 1, 3)

  def self.adjectives = ALL.map(&:adjective)

  def behaviors = Behavior.all.select { |x| x.realm == self }
  def +(other) = behaviors.find { |x| x.attitude == other }

  def adjective = %w[emotional physical financial mental][index]
  def adverb = adjective.ly
  def name = adjective.capitalize
  def intake = %w[listen eat earn watch][index]
  def output = %w[communicate do spend think][index]

  def fast_out = %w[talk/sing walk/run pay\ cash intuit/guess][index]
  def slow_out = %w[use\ words do\ regular\ chores use\ credit use\ logic/symmetry][index]

  def easy_in = %w[to\ music carbs rewards news][index]
  def hard_in = %w[to\ sermons/moral\ stories protein repayments results][index]

  def process = %w[understand digest collect memorize][index]

  def stimulus = %w[sounds smells/tastes texture/heat lights/colors][index]

  def change = %w[tell go build show][index]
  def focus = %w[person place thing idea][index]
  def foci = focus.pluralize
  alias top :foci

  def unfamiliar = %w[friends land machines procedures][index]
  def familiar = %w[family farms hardware software][index]
  def externals = %w[why food shelter how][index]
  def sense = %w[hear smell/taste touch see][index]
  def take =%w[ears nose/mouth wallet eyes][index]
  def basic = %w[stories meals tools signs][index]
  def internals = %w[morals calories value information][index]
  def neuro = %w[oxytocin serotonin dopamine glutamate][index]
  def organ = %w[soul body wallet mind][index]
  alias bottom :organ
  def left = %w[expressive gather labor tactics][index]
  def right = %w[lexical hunt capital logistics][index]
end
