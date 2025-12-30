# frozen_string_literal: true

class Bipolar < Concept
  SKEWS = %w[- +]
  SYMBOLS = Type.strings.collect do |x|
    ["#{x}#{SKEWS.first}", "#{x}#{SKEWS.second}"]
  end.flatten.map(&:to_sym)

  ALL = SYMBOLS.collect { |symbol| new symbol }

  class << self
    def with(subtypes) = ALL.select { |s| (subtypes - s.subtypes).blank? }

    def my_path = "SFTN#{SKEWS.second}"
    def mine = find(my_path)
  end

  def type = Type.find string.chop
  delegate :realms, to: :type
  delegate :subtypes, to: :type

  Mood::SYMBOLS.each do |sym|
    define_method(sym) { subtypes.find { |x| x.mood.symbol == sym } }
  end

  def skew = string.fifth
  def other_skew = SKEWS.without(skew).first
  def depressed? = skew == SKEWS.first
  def partial = depressed? ? 'depressed' : 'manic'

  def title = subtypes.join + skew
  alias link :title
  alias inspect :title


  def sibling_string = "#{string.chop}#{other_skew}"
  def sibling = self.class.find sibling_string

  def behaviors = subtypes.map(&:behaviors).flatten

  def dos
    if depressed?
      behaviors.values_at(0, 3, 5, 7)
    else
      behaviors.values_at(1, 2, 4, 6)
    end
  end

  def similars = self.class.select { |x| (x.dos - dos).blank? }
  def similar = similars.without(self).first

  def yellows = subtypes.rotate

  def donts = sibling.dos

  def differents = self.class.select { |x| (x.donts - donts).blank? }
  def different = differents.without(self).first

  def episodes
    if depressed?
      donts.values_at(2, 3, 1, 0)
    else
      donts.values_at(2, 1, 3, 0)
    end.map(&:realm)
  end

  def mimics = self.class.select { |x| x.episodes == episodes }
  def mimic = mimics.without(self).first
end
