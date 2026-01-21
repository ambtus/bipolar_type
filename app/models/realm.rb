# frozen_string_literal: true

class Realm < Concept
  SYMBOLS = %i[S F T N].freeze
  ALL = SYMBOLS.collect { |symbol| new symbol }
  SYMBOLS.each do |sym|
    define_singleton_method(sym) { ALL.find { |s| s.symbol == sym } }
  end

  def subtypes = Subtype.all.select { |x| x.realm == self }
  def +(other) = subtypes.find { |x| x.mood == other }

  def measurable? = %i[S T].include? symbol

  def name = { F: :social, T: :financial, S: :physical, N: :mental }[symbol].to_s
  def title = [string.colon, name].to_phrase

  def things = { F: :people, T: :tools, S: :foods, N: :ideas }[symbol].to_s
  def appear = { F: :sound, T: :feel, S: 'smell', N: :look }[symbol].to_s

  def change = { F: 'talk', T: :upgrade, S: 'clean/cook', N: :change }[symbol].to_s
  def change_prep = { F: :to }[symbol].to_s
  def change_things = [change, change_prep, things].to_phrase
  def change_them = [change, change_prep, 'them'].to_phrase

  def accept = { F: 'listen', T: :use, S: :eat, N: :use }[symbol].to_s
  def accept_prep = { F: :to,  }[symbol].to_s
  def accept_things = [accept, accept_prep, things].to_phrase
  def accept_them = [accept, accept_prep, 'them'].to_phrase
end
