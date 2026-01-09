# frozen_string_literal: true

class Type < Concept
  BASICS = %w[e i].freeze
  SYMBOLS = Realm.all.permutation(4).collect do |realms|
    ["#{BASICS.first}#{realms.join}", "#{BASICS.second}#{realms.join}"]
  end.flatten.map(&:to_sym)

  ALL = SYMBOLS.collect { |symbol| new symbol }

  class << self
    def my_path = "#{BASICS.second}SFTN"
    def mine = find(my_path)
    def title = 'theory'
  end

  def realms = string.chip.chars.collect { |x| Realm.find x }
  def render = string.first
  def extroverted? = render == BASICS.first
  def breadcrumbs = [render, *realms]

  def subtypes
    if extroverted?
      realms.add(Mood.all).rotate(-1)
    else
      realms.add(Mood.all.rotate(-1))
    end
  end

  def first = extroverted? ? subtypes.values_at(2, 1).join : subtypes[0, 2].join
  def second = extroverted? ? subtypes.values_at(0, 3).join : subtypes[2, 2].join
  def slash = extroverted? ? '/' : '\\'
  def title = [first, second].join(slash)
  alias inspect :title
  alias link :string

  def mbti = String::MBTIS.find { |m| m.make_bipolar_type == title }

  Mood::SYMBOLS.each do |sym|
    define_method(sym) { subtypes.find { |x| x.mood.symbol == sym } }
  end

  def sibling
    if extroverted?
      Type.find ['i', *realms.rotate(-1)].join
    else
      Type.find ['e', *realms.rotate].join
    end
  end

  def behaviors = subtypes.map(&:behaviors).flatten

  def dos
    if extroverted?
      behaviors.values_at(0, 3, 5, 7)
    else
      behaviors.values_at(2, 4, 6, 1)
    end
  end

  def similar
    if extroverted?
      Type.find ['i', *realms.rotate].join
    else
      Type.find ['e', *realms.rotate(2)].join
    end
  end

  def donts
    if extroverted?
      behaviors.values_at(2, 4, 6, 1)
    else
      behaviors.values_at(0, 3, 5, 7)
    end
  end

  def different
    if extroverted?
      Type.find ['i', *realms].join
    else
      Type.find ['e', *realms].join
    end
  end
end
