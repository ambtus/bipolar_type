# frozen_string_literal: true

class Type < Concept
  SYMBOLS = Realm.all.permutation(4).collect do |realms|
    [realms.map(&:string).join + '1', realms.map(&:string).join + '2']
  end.flatten.map(&:to_sym)

  ALL = SYMBOLS.collect { |symbol| new symbol }

  def quads = []

  class << self
    def with(subtypes) = ALL.select { |s| (subtypes - s.subtypes).blank? }.sort

    def title(subtypes = [])
      if subtypes.present?
        "#{with(subtypes).count} BipolarTypes with #{subtypes.and}"
      else
        "#{all.count} BipolarTypes"
      end
    end

    def my_path = 'FTNS2'
    def my_type = find(my_path)
    # for cucumber tests; just needs to be different
    def your_path = 'SNTF1'
    def your_type = find(your_path)
    # for visual tests
    def next_type = my_type.sibling
    def next_path = next_type.path
    def other_type = your_type.sibling
    def other_path = other_type.path
  end

  def bp_type = string.fifth
  def bp1? = bp_type == '1'
  def bp = "bp#{bp_type}"
  def <=>(other) = bp_type <=> other.bp_type

  def realms = string.chop.chars.collect { |x| Realm.find(x) }
  def subtypes = realms.add(Mood.all)
  def nature = Nature.find_by subtypes

  def behaviors = subtypes.map(&:behaviors).flatten

  def sibling_string = bp1? ? string.chop + '2' : string.chop + '1'
  def sibling = Type.find sibling_string

  def dos
    if bp1?
      [p.ep, e.ej, j.ij, i.ip]
    else
      [p.ip, e.ep, j.ej, i.ij]
    end
  end

  def similars = Type.select { |x| (x.dos - dos).blank? }
  def similar = similars.without(self).first

  def donts = sibling.dos

  def differents = Type.select { |x| (x.donts - donts).blank? }
  def different = differents.without(self).first

  def manic_realms = bp1? ? realms[1,2] : realms[0,2]
  def mania = "#{manic_realms.map(&:adjective).amp} mania"

  def depressed_realms = bp1? ? realms.values_at(3,0) : realms[2,2]
  def depression = "#{depressed_realms.map(&:adjective).amp} depression"

  Mood::SYMBOLS.each do |sym|
    define_method(sym) { subtypes.find { |x| x.mood.symbol == sym } }
  end
end
