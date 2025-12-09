# frozen_string_literal: true

class Type < Concept
  SYMBOLS = Realm.strings.permutation(4).collect do |realms|
    [
      "e#{realms[0, 2].join}p/i#{realms[2, 2].join}j",
      "i#{realms[0, 2].join}p/e#{realms[2, 2].join}j"
    ]
  end.flatten.map(&:to_sym)

  ALL = SYMBOLS.collect { |symbol| new symbol }

  alias inspect :string
  alias title :string

  class << self
    def with(subtypes) = ALL.select { |s| (subtypes - s.subtypes).blank? }.sort

    def title(subtypes = [])
      if subtypes.present?
        "#{Type.with(subtypes).count} BipolarTypes with #{subtypes.and}"
      else
        "#{all.count} BipolarTypes"
      end
    end

    def my_path = 'iSFp/eTNj'
    def my_type = find(my_path)
    # for cucumber tests; just needs to be different
    def your_path = 'eSNp/iTFj'
    def your_type = find(your_path)
    # for visual tests
    def next_type = my_type.sibling
    def next_path = next_type.path
    def other_type = your_type.sibling
    def other_path = other_type.path
  end

  def subtypes = string.delete('/').scan(/../).collect { |x| Subtype.find(x) }
  def behaviors = subtypes.map(&:behaviors).flatten

  def nature = Nature.find_by subtypes

  def type = self

  def bp1? = string.first == 'e'
  def bp_type = bp1? ? 1 : 2
  def <=>(other) = bp_type <=> other.bp_type

  def family = Type.select { |x| x.subtypes.sort == subtypes.sort }.sort
  def sibling = family.without(self).first

  def similars = Type.select {|x| x.episodes == episodes}
  def similar = similars.without(self).first

  def balance = bp1? ? 'left' : 'right'
  def excess = bp1? ? 'right' : 'left'

  def manic_type = bp1? ? 'euphoric' : 'irritable'
  def manic_realm = bp1? ? subtypes.first.realm : subtypes.third.realm
  def mania = "#{manic_type} #{manic_realm.short_words} mania"

  def depressed_type = bp1? ? 'lethargic' : 'insatiable'
  def depressed_realm = bp1? ? subtypes.third.realm : subtypes.first.realm
  def depression = "#{depressed_type} #{depressed_realm.short_words} depression"

  def episodes = bp1? ? [mania, depression].amp : [depression, mania].amp


  Mood::SYMBOLS.each do |sym|
    define_method(sym) { subtypes.find { |x| x.mood.symbol == sym } }
  end
end
