# frozen_string_literal: true

class Action < Concept
  SYMBOLS = %i[ip ep ej ij].freeze
  ALL = SYMBOLS.collect { |symbol| new symbol }
  SYMBOLS.each do |sym|
    define_singleton_method(sym) { ALL.find { |s| s.symbol == sym } }
  end

  alias render :string
  def ordinal = %w[first second third fourth][index]
  def life_phase = %w[children adolescent adult retired][index]
  def solar_year = %w[spring summer autumn winter][index]
  def next_path = %i[ep_path ej_path ij_path type_path][index]

  def behaviors = Behavior.all.select { |x| x.action == self }
  def +(other) = behaviors.find { |x| x.realm == other }

  def moods = Mood.select { |x| string.chars.include?(x.string) }

  def basic = Basic.find(string.first)
  delegate :verb, to: :basic
  %i[object verb].each do |sym|
    delegate sym, to: :basic
  end

  def noun = string.second == 'p' ? 'energy' : 'strength'
  def action = [verb, noun].to_phrase

  def adjective = string.second == 'p' ? 'urgent' : 'important'
  def focus = [adjective, object].to_phrase

  def episode = index == 2 ? moods.reverse.map(&:mood).to_phrase : moods.map(&:mood).to_phrase
end
