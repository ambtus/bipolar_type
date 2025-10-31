# frozen_string_literal: true

class Behavior < Concept
  SYMBOLS = Realm.all.collect do |realm|
    Attitude.all.collect do |attitude|
      (attitude.string.first + realm.string + attitude.string.second).to_sym
    end
  end.flatten

  ALL = SYMBOLS.collect { |symbol| new symbol }
  SYMBOLS.each do |sym|
    define_singleton_method(sym) { ALL.find { |s| s.symbol == sym } }
  end

  def realm = Realm.find(string.second)
  def attitude = Attitude.find(string.first + string.third)

  delegate :<=>, to: :attitude

  %i[previous next opposite flip flop].each do |sym|
    define_method(sym) { realm + attitude.send(sym) }
  end
end
