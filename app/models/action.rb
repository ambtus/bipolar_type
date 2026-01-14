# frozen_string_literal: true

class Action < Concept
  SYMBOLS = Mood::SYMBOLS.values_at(0,2).collect do |first|
    Mood::SYMBOLS.values_at(1,3).collect do |second|
      "#{first}#{second}".to_sym
    end
  end.flatten.values_at(1,0,2,3)
  ALL = SYMBOLS.collect { |symbol| new symbol }
  SYMBOLS.each do |sym|
    define_singleton_method(sym) { ALL.find { |s| s.symbol == sym } }
  end

  def behaviors = Behavior.all.select { |x| x.action == self }
  def +(other) = behaviors.find { |x| x.realm == other }

  def moods = Mood.select { |x| string.chars.include?(x.string) }

end
