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

  def advice
    [greens.first.long_others, greens.second.long_myself, greens.third.long_myself, greens.fourth.long_others]
  end

  def nurtured_dependent = clockwise? ? sibling.greens.even : sibling.greens.odd
  def nurtured_independent = clockwise? ? sibling.greens.odd : sibling.greens.even

  def nurtures
    (nurtured_dependent.map(&:long_others) + nurtured_independent.map(&:long_myself))
  end

  def sorted_nurtures
    if clockwise?
      nurtures.values_at(0,2,1,3)
    else
      nurtures.values_at(0,3,1,2)
    end
  end

  def sorted_advice
    if clockwise?
      advice.rotate
    else
      advice
    end
  end
end
