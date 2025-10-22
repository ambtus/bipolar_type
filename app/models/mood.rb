# frozen_string_literal: true

class Mood < Concept
  SYMBOLS = %i[p e j i].freeze
  ALL = SYMBOLS.collect { |symbol| new symbol }
  SYMBOLS.each do |sym|
    define_singleton_method(sym) { ALL.find { |s| s.symbol == sym } }
  end

  def self.names = ALL.map(&:name)
  def self.titles = ALL.map(&:title)
  def self.episodes = ALL.map(&:episode)

  def subtypes = Subtype.all.select { |x| x.string.match string }
  def +(other) = subtypes.find { |x| x.string.match other.string }

  def attitudes = Attitude.all.select {|x| x.string.match string}

  def name = %w[energy output strength intake][index]

  def season = %w[spring summer fall winter][index]
  def time_of_day = %w[forward day back night][index]
  def noun = %w[prey extroverted predator introverted][index]
  def adjective = %w[playful active responsible receptive][index]
  def neutral = %w[agile high powerful down][index]
  def bad = %w[young stressed old bored][index]
  def goal = %w[freedom activity control passivity][index]

  def words = [season, time_of_day, noun, neutral, bad, adjective, goal]

  def time = [season, time_of_day].to_phrase
  def title = [season, goal].to_phrase
  def link = [season, goal, name.wrap].to_phrase

  def horizontal? = %i[p j].include? symbol

end
