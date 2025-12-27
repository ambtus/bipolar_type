# frozen_string_literal: true

class Action < Concept
  SYMBOLS = %i[ip ep ej ij].freeze
  ALL = SYMBOLS.collect { |symbol| new symbol }
  SYMBOLS.each do |sym|
    define_singleton_method(sym) { ALL.find { |s| s.symbol == sym } }
  end

  def behaviors = Behavior.all.select { |x| x.action == self }
  def +(other) = behaviors.find { |x| x.realm == other }

  def moods = Mood.select { |x| string.chars.include?(x.string) }

  def verb = %w[get burn use rebuild][index]
  def noun = string.second == 'p' ? 'energy' : 'strength'

  def adjective = string.second == 'p' ? 'urgent' : 'important'
  def focus = string.first == 'i' ? 'needs' : 'tasks'

  def technical = ['refuel', 'flee from', 'fight', 'rest'][index]
end
