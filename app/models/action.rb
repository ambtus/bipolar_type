# frozen_string_literal: true

class Action < Concept
  SYMBOLS = %i[ip ep ej ij].freeze
  ALL = SYMBOLS.collect { |symbol| new symbol }
  SYMBOLS.each do |sym|
    define_singleton_method(sym) { ALL.find { |s| s.symbol == sym } }
  end

  def behaviors = Behavior.all.select { |x| x.action == self }
  def +(other) = behaviors.find { |x| x.realm == other }


  def moods = string.chars.collect{|x| Mood.find(x)}

  def wise = { ip: :refuel, ep: 'flee (find new things)', ej: 'fight (improve familiar things)', ij: :rest }[symbol].to_s

  def foolish = moods.reverse.map(&:foolish).to_phrase
end
