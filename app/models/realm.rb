# frozen_string_literal: true

class Realm < Concept
  SYMBOLS = %i[F T N S].freeze
  ALL = SYMBOLS.collect { |symbol| new symbol }
  SYMBOLS.each do |sym|
    define_singleton_method(sym) { ALL.find { |s| s.symbol == sym } }
  end

  def subtypes = Subtype.all.select { |x| x.realm == self }

  def +(other) =subtypes.find { |x| x.mood == other }

  def measurable? = %i[S T].include? symbol

  def wise = { F: :spiritual, T: :material, S: :physical, N: :mental }[symbol].to_s
  def persona = { F: :soul, T: :wallet, S: :body, N: :mind }[symbol].to_s
  def energy = { F: :hope, T: :money, S: :calories, N: :information }[symbol].to_s
  def resources = { F: :stories, T: :things, S: :foods, N: :ideas }[symbol].to_s

  def accept = { F: :listen, T: :sell, S: :eat, N: :remember }[symbol].to_s
  def prep = { F: :to }[symbol].to_s
  def change = { F: :say, T: :buy, S: :move, N: :show }[symbol].to_s

  def appear = { F: :sound, T: :feel, S: 'smell/taste', N: :look }[symbol].to_s
  def appears = appear.s
  def healthy = { F: :moral, T: :useful, S: :nutritious, N: true }[symbol].to_s

  def first_half = [accept.ing.capitalize, 'so your', persona, 'has enough', energy, 'to', change].to_phrase
  def second_half = [change.ing, 'so there are enough', resources, 'to', accept, prep].to_phrase
end
