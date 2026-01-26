# frozen_string_literal: true

class Realm < Concept
  SYMBOLS = %i[F T N S].freeze
  ALL = SYMBOLS.collect { |symbol| new symbol }
  SYMBOLS.each do |sym|
    define_singleton_method(sym) { ALL.find { |s| s.symbol == sym } }
  end

  def subtypes = Subtype.all.select { |x| x.realm == self }

  def +(other) =subtypes.find { |x| x.mood == other }

  Action::SYMBOLS.each do |sym|
    define_method(sym) { Behavior.all.find { |x| x.action.symbol == sym && x.realm.symbol == symbol } }
  end

  def wise = { F: :social, T: :financial, S: :physical, N: :mental }[symbol].to_s
  def accept = { F: :listen, T: :work, S: :eat, N: :see }[symbol].to_s
  def change = { F: :talk, T: :spend, S: :move, N: :think }[symbol].to_s
  def appear = { F: :sound, T: :feel, S: 'smell/taste', N: :look }[symbol].to_s
  def energy = { F: :hope, T: :money, S: :calories, N: :information }[symbol].to_s
end
