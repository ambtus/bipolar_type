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

  def quads = string.split('/')

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

  def bp1? = string.first == 'e'
  def bp_type = bp1? ? 1 : 2
  def bp = "bp#{bp_type}"
  def <=>(other) = bp_type <=> other.bp_type
  def bp_name = "Bipolar #{bp1? ? 'I' : 'II'}"

  def subtypes = string.delete('/').scan(/../).collect { |x| Subtype.find(x) }
  def nature = Nature.find_by subtypes

  def ordered_subtypes
    if bp1?
      subtypes.values_at(1, 0, 3, 2)
    else
      subtypes.values_at(1, 2, 3, 0)
    end
  end

  def behaviors = subtypes.map(&:behaviors).flatten

  def siblings = Type.select { |x| x.subtypes.sort == subtypes.sort }.sort
  def sibling = siblings.without(self).first

  def dos
    if bp1?
      [p.ep, e.ej, j.ij, i.ip]
    else
      [p.ip, e.ep, j.ej, i.ij]
    end
  end

  def similars = Type.select { |x| (x.dos - dos).blank? }
  def similar = similars.without(self).first

  def donts
    if bp1?
      [p.ip, e.ep, j.ej, i.ij]
    else
      [p.ep, e.ej, j.ij, i.ip]
    end
  end

  def differents = Type.select { |x| (x.donts - donts).blank? }
  def different = differents.without(self).first

  def manic_type = bp1? ? 'mania' : 'hypomania'
  def manic_realm = bp1? ? subtypes.first.realm : subtypes.third.realm
  def mania = "#{manic_realm.short_words} #{manic_type}"

  def depressed_prefix = bp1? ? '' : 'major'
  def depressed_realm = bp1? ? subtypes.third.realm : subtypes.first.realm
  def depression = [depressed_prefix, depressed_realm.short_words, 'depression'].to_phrase

  def episodes = bp1? ? [mania, depression] : [depression, mania]

  Mood::SYMBOLS.each do |sym|
    define_method(sym) { subtypes.find { |x| x.mood.symbol == sym } }
  end
end
