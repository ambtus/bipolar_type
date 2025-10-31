# frozen_string_literal: true

class Type < Concept
  SYMBOLS = Realm.strings.permutation(4).collect do |realms|
    ["e#{realms[0, 2].join}pi#{realms[2, 2].join}j",
     "i#{realms[0, 2].join}pe#{realms[2, 2].join}j"]
  end.flatten.map(&:to_sym)

  ALL = SYMBOLS.collect { |symbol| new symbol }

  class << self
    def with(subtypes) = ALL.select { |s| (subtypes - s.subtypes).blank? }
    def bp1(subtypes) = with(subtypes).find(&:bp1?)
    def bp2(subtypes) = with(subtypes).find(&:bp2?)
    def my_path = :iSFpeTNj
    def my_type = find(my_path)
    # for cucumber tests; just needs to be different
    def your_type = bp1(my_type.subtypes.map(&:opposite))
    def your_path = your_type.path
    # for visual tests
    def next_type = bp2(my_type.subtypes.map(&:next))
    def next_path = next_type.path
    def other_type = bp1(my_type.subtypes)
    def other_path = other_type.path
  end

  alias title :string

  def subtypes = string.scan(/../).collect { |x| Subtype.find(x) }.sort_by(&:mood)
  def realms = subtypes.map(&:realm)

  def bp1? = string.starts_with?('e')
  def bp2? = string.starts_with?('i')

  def balance = bp1? ? 'left' : 'right'
  def excess = bp1? ? 'right' : 'left'

  Mood::SYMBOLS.each do |sym|
    define_method(sym) { subtypes.find { |x| x.mood.symbol == sym } }
  end
end
