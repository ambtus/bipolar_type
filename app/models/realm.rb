# frozen_string_literal: true

class Realm < Concept
  SYMBOLS = %i[F S T N].freeze
  ALL = SYMBOLS.collect { |symbol| new symbol }
  SYMBOLS.each do |sym|
    define_singleton_method(sym) { ALL.find { |s| s.symbol == sym } }
  end

  def self.linear = ALL.values_at(1, 3, 0, 2)

  def behaviors = Behavior.all.select { |x| x.realm == self }
  def subtypes = Subtype.all.select { |x| x.realm == self }

  def +(other)
    return behaviors.find { |x| x.attitude == other } if other.is_a? Attitude
    return subtypes.find { |x| x.mood == other } if other.is_a? Mood

    raise "cannot add #{other.class} to realm"
  end
end
