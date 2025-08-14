# frozen_string_literal: true

class Subtype < Concept
  SYMBOLS = 4.times do |priority|
    Subtype.all.collect do |subtype|
      (subtype.string + (priority + 1)).to_sym
    end
  end.flatten

  ALL = SYMBOLS.collect { |symbol| new symbol }

  def behavior = Behavior.find(string.chop)
  def ordinal = string.last.to_i.ordinalize
end
