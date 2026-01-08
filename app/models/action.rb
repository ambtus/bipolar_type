# frozen_string_literal: true

class Action < Concept
  SYMBOLS = %i[ip ep ej ij].freeze
  ALL = SYMBOLS.collect { |symbol| new symbol }
  SYMBOLS.each do |sym|
    define_singleton_method(sym) { ALL.find { |s| s.symbol == sym } }
  end

  alias render :string
  def position = %w[first second third fourth][index]
  def problem = %w[obese anorexic strained weak][index]
  def next_path = %i[ep_path ej_path ij_path type_path][index]

  def behaviors = Behavior.all.select { |x| x.action == self }
  def +(other) = behaviors.find { |x| x.realm == other }

  def moods = Mood.select { |x| string.chars.include?(x.string) }

  def unhappy = string.first == 'i' ? 'stressed' : 'bored'

  def verb = string.first == 'i' ? 'get' : 'use'
  def noun = string.second == 'p' ? 'energy' : 'strength'
  def generic = [verb, noun].to_phrase

  def adjective = string.second == 'p' ? 'urgent' : 'important'
  def object = string.first == 'i' ? 'needs' : 'tasks'
  def focus = [adjective, object].to_phrase
end
