# frozen_string_literal: true

class Realm < Concept
  SYMBOLS = %i[e p f m].freeze
  ALL = SYMBOLS.collect { |symbol| new symbol }
  SYMBOLS.each do |sym|
    define_singleton_method(sym) { ALL.find { |s| s.symbol == sym } }
  end

  def self.mine = ALL.values_at(0, 2, 1, 3)

  def self.linear = ALL.values_at(1, 3, 0, 2)

  def self.adjectives = linear.map(&:adjective)

  def behaviors = Behavior.all.select { |x| x.realm == self }
  def +(other) = behaviors.find { |x| x.attitude == other }

  def adjective = %w[emotional physical financial mental][index]
  def adverb = %w[spiritually physically materially cognitively][index]
  def name = adjective.capitalize
  def intake = %w[listen eat earn watch][index]
  def output = %w[talk move spend plan][index]

  def fast_out = %w[emote\ or\ sing walk\ or\ run pay\ cash intuit\ or\ guess][index]
  def slow_out = %w[use\ words do\ chores use\ credit use\ logic\ or\ symmetry][index]

  def easy = %w[to\ music carbs rewards the\ news][index]
  def hard = %w[to\ sermons protein repayments results][index]

  def easy_intake = [intake, easy].to_phrase
  def hard_intake = [intake, hard].to_phrase

  def process = %w[understand digest collect memorize][index]

  def resources = %w[stories foods rewards facts][index]

  def stimulus = %w[sounds smells\ or\ tastes textures colors\ or\ shapes][index]

  def change = %w[tell go build show][index]
  def focus = %w[person place tool idea][index]
  def foci = focus.pluralize
  alias top :foci

  def sense = %w[hear smell/taste touch see][index]
  def neuro = %w[oxytocin serotonin dopamine glutamate][index]
  def organ = %w[heart body wallet mind][index]

  def energy = %w[emotions calories money information][index]

end
