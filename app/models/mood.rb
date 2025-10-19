# frozen_string_literal: true

class Mood < Concept
  SYMBOLS = %i[p e j i].freeze
  ALL = SYMBOLS.collect { |symbol| new symbol }
  SYMBOLS.each do |sym|
    define_singleton_method(sym) { ALL.find { |s| s.symbol == sym } }
  end

  def self.names = ALL.map(&:name)

  def subtypes = Subtype.all.select { |x| x.string.match string }
  def +(other) = subtypes.find { |x| x.string.match other.string }

  def attitudes = Attitude.all.select {|x| x.string.match string}

  def bipolar? = index.odd?

  def rather = %w[ip ep ej ij][index]

  def name = %w[energy output strength intake][index]
alias link :name

  def season = %w[spring summer fall winter][index]
  def time_of_day = %w[forward day back night][index]
  def noun = %w[prey extroverted predator introverted][index]
  def good = %w[playful active responsible receptive][index]
  def neutral = %w[agile high powerful down][index]
  def bad = %w[young stressed old bored][index]
  def goal = %w[freedom change control acceptance][index]
  
  def words = [season, time_of_day, noun, neutral, bad, good, goal]
  

  
  def time = [season, time_of_day].to_phrase
  def title = [season, goal].to_phrase

end
