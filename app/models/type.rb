# frozen_string_literal: true

class Type < Concept
  SYMBOLS = Nature.strings.collect do |x|
    ["#{x}1", "#{x}2"]
  end.flatten.map(&:to_sym)

  ALL = SYMBOLS.collect { |symbol| new symbol }

  def nature = Nature.find string.chop
  delegate :realms, to: :nature
  delegate :subtypes, to: :nature

  Mood::SYMBOLS.each do |sym|
    define_method(sym) { subtypes.find { |x| x.mood.symbol == sym } }
  end

  def bp_type = string.fifth
  def bp1? = bp_type == '1'
  def bp = "bp#{bp_type}"
  def bp_arrow = bp1? ? '<' : '>'

  def partial_title = subtypes.join('•')
  def title = bp1? ? [bp_arrow, partial_title].join : [partial_title, bp_arrow].join
  alias link :title
  alias inspect :title

  class << self
    def with(subtypes) = ALL.select { |s| (subtypes - s.subtypes).blank? }.sort

    def my_path = 'SFTN2'
    def my_type = find(my_path)
    # for cucumber tests; just needs to be different
    def your_path = 'FSNT1'
    def your_type = find(your_path)
    # for visual tests
    def next_type = my_type.sibling
    def next_path = next_type.path
    def other_type = your_type.sibling
    def other_path = other_type.path
  end

  def <=>(other) = bp_type <=> other.bp_type

  def sibling_string = bp1? ? "#{string.chop}2" : "#{string.chop}1"
  def sibling = Type.find sibling_string

  def behaviors = subtypes.map(&:behaviors).flatten

  def dos = bp1? ? behaviors.values_at(0, 3, 5, 7) : behaviors.values_at(1, 2, 4, 6)

  def similars = Type.select { |x| (x.dos - dos).blank? }
  def similar = similars.without(self).first

  def yellows = subtypes.rotate

  def donts = sibling.dos

  def differents = Type.select { |x| (x.donts - donts).blank? }
  def different = differents.without(self).first

  def episodes
    if bp1?
      donts.values_at(2, 3, 1, 0)
    else
      donts.values_at(2, 1, 3, 0)
    end.map(&:realm)
  end

  def mimics = Type.select { |x| x.episodes == episodes }
  def mimic = mimics.without(self).first
end
