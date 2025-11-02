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

  def episode = ['agitated depression', 'euphoric mania', 'irritable mania', 'lethargic depression'][index]
    def aka = ['digest too much', 'flee too much', 'fight too much', 'rest too much'][index]
  def episode_type = [episode, aka.wrap].to_phrase


  def bp1? = index.odd?
end
