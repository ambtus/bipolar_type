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
  def behaviors = subtypes.map(&:behaviors)

  def manic_realm = clockwise? ? subtypes.first : subtypes.third
  def depressed_realm = clockwise? ? subtypes.third : subtypes.first
  def mania = "e#{manic_realm}/#{realms.second}"
  def depression = "i#{depressed_realm}/#{realms.fourth}"
  def both = [mania, depression]
  def wise = clockwise? ? both.amp : both.reverse.amp

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

  def friend
    if clockwise?
      Type.find [*realms.rotate(-1), other].join
    else
      Type.find [*realms.rotate, other].join
    end
  end
end
