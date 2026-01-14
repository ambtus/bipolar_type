# frozen_string_literal: true

class Type < Concept
  SYMBOLS = Realm.all.permutation(4).collect do |realms|
    Basic.all.collect do |basic|
      :"#{basic}#{realms.join}"
    end
  end.flatten

  ALL = SYMBOLS.collect { |symbol| new symbol }

  class << self
    def my_path = [Basic.mine, *Realm.my_order].join
    def mine = find(my_path)
    def title = 'theory'
  end

  def basic = Basic.find string.first
  delegate :extroverted?, :first_color, :second_color, to: :basic

  def realms = string.chip.chars.collect { |x| Realm.find x }

  def subtypes = realms.add(Mood.all)

  alias inspect :string
  alias link :string

  Mood::SYMBOLS.each do |sym|
    define_method(sym) { subtypes.find { |x| x.mood.symbol == sym } }
  end

  def other_skew = basic.other
  def sibling = Type.find [other_skew, *realms].join

  def behaviors = subtypes[0, 3].map(&:behaviors) + [subtypes.last.behaviors.reverse]

  def dos
    if extroverted?
      behaviors.map(&:second)
    else
      behaviors.map(&:first)
    end
  end

  def donts = sibling.dos

  def similar
    if extroverted?
      Type.find [other_skew, *realms.rotate(-1)].join
    else
      Type.find [other_skew, *realms.rotate(1)].join
    end
  end

  def different
    if extroverted?
      Type.find [other_skew, *realms.rotate(1)].join
    else
      Type.find [other_skew, *realms.rotate(-1)].join
    end
  end
end
