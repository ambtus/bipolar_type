# frozen_string_literal: true

class Realm < Concept
  SYMBOLS = %i[S T F N].freeze
  ALL = SYMBOLS.collect { |symbol| new symbol }
  SYMBOLS.each do |sym|
    define_singleton_method(sym) { ALL.find { |s| s.symbol == sym } }
  end

  def self.mine = all.values_at(2,1,3,0)

  def behaviors = Behavior.all.select { |x| x.realm == self }

  def subtypes = Subtype.all.select { |x| x.realm == self }

  def +(other) =subtypes.find { |x| x.mood == other }

  Action::SYMBOLS.each do |sym|
    define_method(sym) { Behavior.all.find { |x| x.action.symbol == sym && x.realm.symbol == symbol } }
  end

  Mood::SYMBOLS.each do |sym|
    define_method(sym) { Subtype.all.find { |x| x.mood.symbol == sym && x.realm.symbol == symbol } }
  end

  def wise = { F: :social, T: :financial, S: :physical, N: :mental }[symbol].to_s
  def adverb = wise.ly

  def accept = { F: :hear, T: :earn, S: :eat, N: :watch }[symbol].to_s
  def given = { F: :told, T: :paid, S: :fed, N: :shown }[symbol].to_s

  def change = { F: :talk, T: :spend, S: :move, N: :think }[symbol].to_s
  def targets = { F: :people, T: :tools, S: :foods, N: :ideas}[symbol].to_s

  def appear = { F: :sound, T: :feel, S: 'smell/taste', N: :look }[symbol].to_s
  def energy = { F: :hope, T: :money, S: :calories, N: :information }[symbol].to_s

  ZEITGEBERS  = {
    N: 'The sunrise in the morning; the sunset at night. The full moon or new moon.',
    S: 'Breakfast in the morning; supper at night. Thanksgiving feasts and Lenten fasts.',
    F: 'Reveille in the morning; taps in the evening. Sunday morning services; three minutes of silence.',
    T: 'The warmth of day; the cold of night. Long weeks; short weekends.'
  }

  def zeitgebers = ZEITGEBERS[symbol].html_safe
  def signal = { F: :decibels, T: :temperature, S: :ppm, N: :lux }[symbol].to_s
  def geber = { F: :sound, T: :heat, S: :seasonings, N: :lights }[symbol].to_s

  def weak = { F: :soft, T: :cold, S: :bland, N: :dim }[symbol].to_s
  def strong = { F: :loud, T: :hot, S: :pungent, N: :bright }[symbol].to_s

end
