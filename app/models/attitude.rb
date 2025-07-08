# frozen_string_literal: true

class Attitude < Concept
  SYMBOLS = %i[BL TL TR BR].freeze
  ALL = SYMBOLS.collect { |symbol| new symbol }
  SYMBOLS.each do |sym|
    define_singleton_method(sym) { ALL.find { |s| s.symbol == sym } }
  end

  def first? = symbol == :BL
  def top? = string.starts_with?('T')
  def left? = string.ends_with?('L')
  def diagonal? = %i[BL TR].include?(symbol)

  def gu = %w[get burn use recover][index]
  def es = left? ? 'energy' : 'strength'
  def action = [gu, es].join('_')
  def do_something = [gu, es].to_phrase

  def first_letter = gu.first.capitalize
  def second_letter = es.first.capitalize

  def daytime = %w[morning noon afternoon evening][index]
  def season = %w[spring summer fall winter][index]
  def time = [season, daytime].to_phrase.titleize

  def feel = %w[emptiness fear anger tired][index]
  def feeling = %w[empty afraid angry sore][index]
  def react = %w[digest flee fight rest][index]
  def finish = ['fill up', 'escape', 'win', 'sleep'][index]
  # your organ
  def word = %w[feed move work rest][index]
  def bad = %w[greedy paranoid hateful lazy][index]
  def bipolar_result = %w[explode die collapse panic][index]
  def name = word.capitalize

  def what = %w[room energy strength time][index]
  def problem = "run out of #{what}"

  def md = top? ? 'mania' : 'depression'
  def description = %w[major euphoric irritable agitated][index]
  def episode = [description, md].to_phrase.titleize

  def flip = Attitude.without(self).find { |a| a.string.second == string.second }
  def flop = Attitude.without(self).find { |a| a.string.first == string.first }

  def subtypes = Subtype.all.select { |x| x.attitude == self }
  def +(other) = subtypes.find { |x| x.realm == other }
end
