# frozen_string_literal: true

class Realm < Concept
  SYMBOLS = %i[S N F T].freeze
  ALL = SYMBOLS.collect { |symbol| new symbol }
  SYMBOLS.each do |sym|
    define_singleton_method(sym) { ALL.find { |s| s.symbol == sym } }
  end

  def self.my_order = all.values_at(2,3,1,0)

  def subtypes = Subtype.all.select { |x| x.realm == self }

  def +(other) =  subtypes.find { |x| x.mood == other }

  def realm = %w[physical mental social financial][index]

end
