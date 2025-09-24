# frozen_string_literal: true

class Mood < Concept
  SYMBOLS = %i[p e j i ].freeze
  ALL = SYMBOLS.collect { |symbol| new symbol }
  SYMBOLS.each do |sym|
    define_singleton_method(sym) { ALL.find { |s| s.symbol == sym } }
  end

  def attitudes = Attitude.all.select { |x| x.string.match self.string }
  def subtypes = Subtype.all.select { |x| x.string.match self.string }
  def +(realm) = subtypes.find { |x| x.string.match self.string }

  def location = %w[left top right bottom ][index]
  %w[left top right bottom ].each do |meth|
    define_method("#{meth}?") {location == meth}
  end
  def better = [Attitude.ip, Attitude.ep, Attitude.ej, Attitude.ij][index]
  def worse = [Attitude.ep, Attitude.ej, Attitude.ij, Attitude.ip][index]

  def episode = %w[escape mania control depression ][index]
  def mood = episode.to_adjective


  def season = %w[spring summer autumn winter ][index]
  alias name :season

  def self.names = ALL.map(&:name)

  def how = %w[free fatter controlled thinner][index]



end
