# frozen_string_literal: true

class Type < Concept
  SYMBOLS = Realm.all.permutation(4).collect do |realms|
    Skew.all.collect do |skew|
      :"#{realms.join}#{skew}"
    end
  end.flatten

  ALL = SYMBOLS.collect { |symbol| new symbol }

  class << self
    def my_path = [*Realm.all, Skew.mine].join
    def mine = find(my_path)
  end

  def skew = Skew.find string.last
  delegate :clockwise?, :first_color, :second_color, :other, to: :skew

  def realms = string[0, 4].chars.collect { |x| Realm.find x }
  def subtypes = realms.add(Mood.all)
  def wise = subtypes.join('•')
  def behaviors = subtypes.map(&:behaviors)

  Mood::SYMBOLS.each do |sym|
    define_method(sym) { subtypes.find { |x| x.mood.symbol == sym } }
  end

  def sibling = Type.find [*realms, other].join

  def greens
    if clockwise?
      behaviors.map(&:second)
    else
      behaviors.map(&:first)
    end.sort
  end

  def flop_first = greens.each_with_index.map { |x, i| i.even? ? x.flop : x.opposite }
  def flop_second = greens.each_with_index.map { |x, i| i.even? ? x.opposite : x.flop }

  def reds = clockwise? ? flop_first : flop_second

  def friend
    if clockwise?
      Type.find [*realms.rotate(-1), other].join
    else
      Type.find [*realms.rotate, other].join
    end
  end
end
