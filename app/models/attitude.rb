# frozen_string_literal: true

class Attitude < Concept
  SYMBOLS = %i[ip ep ej ij].freeze
  ALL = SYMBOLS.collect { |symbol| new symbol }
  SYMBOLS.each do |sym|
    define_singleton_method(sym) { ALL.find { |s| s.symbol == sym } }
  end

  def self.linear = ALL.values_at(3, 0, 1, 2)

  def behaviors = Behavior.all.select { |x| x.attitude == self }
  def +(other) = behaviors.find { |x| x.realm == other }

  def top? = string.starts_with?('e')
  def bottom? = string.starts_with?('i')
  def left? = string.ends_with?('p')
  def right? = string.ends_with?('j')

  def execute = top? ? 'use' : 'get'
  def which = left? ? 'energy' : 'strength'

  def phrase = [execute, which].to_phrase
  alias link :phrase

  def time_of_day = %w[morning forenoon afternoon evening][index]
  def good = %w[empty energetic productive tired][index]
  def neutral = %w[hungry anxious irritable sore][index]
  def bad = %w[starving afraid angry exhausted][index]
  def react = %w[digest flee fight rest][index]
  def goal = %w[refuel escape win recover][index]

  def words = [neutral, time_of_day, good, bad, react, goal]

  


end
