# frozen_string_literal: true

class Basic < Concept
  SYMBOLS = %i[e i].freeze
  ALL = SYMBOLS.collect { |symbol| new symbol }
  SYMBOLS.each do |sym|
    define_singleton_method(sym) { ALL.find { |s| s.symbol == sym } }
  end

  def e? = index.zero?

  def other = e? ? Basic.i : Basic.e

  def verb = e? ? 'use' : 'get'
  def adjective = e? ? 'extroverted' : 'introverted'
  def noun = e? ? 'extrovert' : 'introvert'

  def location = e? ? 'external' : 'internal'
  def object = e? ? 'tasks' : 'needs'
  def focus = [location, object].to_phrase

  def too = e? ? 'too_little' : 'too_much'

  def worse_episode = e? ? 'depression' : 'mania'
  def unhappy = e? ? 'bored' : 'stressed'
  def preference = e? ? 'interesting' : 'safe'
  def risk_profile = e? ? 'risk-seeking' : 'risk-averse'
  def sensitivity = e? ? 'oblivious' : 'hypsersensitive'
  def harder_to = e? ? 'wake up' : 'fall asleep'
  def tendency = e? ? 'hypersomnia' : 'insomnia'
  def drink = e? ? 'morning cuppa' : 'evening nightcap'
  def drug = e? ? 'caffeine' : 'alcohol'
  def favorite_drink = [drink, drug.wrap].break

  def first_problem = e? ? 'skinny' : 'fat'
  def second_problem = other.first_problem
  def third_problem = e? ? 'weak' : 'strained'
  def fourth_problem = other.third_problem

end
