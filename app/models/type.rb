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
  end

  alias link :string
  alias breadcrumbs :string
  def realms = string.chip.chars.collect { |x| Realm.find x }


  def basic = string.first
  def extroverted? = basic == BASICS.first
  def i_title = string[0,3] + "pe" + string[3,2] + 'j'
  def e_title = "e" + string[1,2].reverse + "pi" + string.chip.reverse[0,2] + 'j'
  def title = extroverted? ? e_title : i_title
  alias inspect :title


  def subtypes
    if extroverted?
      realms.add(Mood.all).rotate(-1)
    else
      realms.add(Mood.all.rotate(-1))
    end
  end

  Mood::SYMBOLS.each do |sym|
    define_method(sym) { subtypes.find { |x| x.mood.symbol == sym } }
  end

  def siblings = self.class.select { |x| (x.subtypes - subtypes).blank? }
  def sibling = siblings.without(self).first

  def behaviors = subtypes.map(&:behaviors).flatten

  def dos
    if extroverted?
      behaviors.values_at(0, 3, 5, 7)
    else
      behaviors.values_at(2, 4, 6, 1)
    end
  end

  def similars = self.class.select { |x| (x.dos - dos).blank? }
  def similar = similars.without(self).first

  def donts
    if extroverted?
      behaviors.values_at(2, 4, 6, 1)
    else
      behaviors.values_at(0, 3, 5, 7)
    end
  end

  def differents = self.class.select { |x| (x.donts - donts).blank? }
  def different = differents.without(self).first
end
