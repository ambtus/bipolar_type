# frozen_string_literal: true

class Nature < Concept
  SO = [2, 0, 1, 3].freeze
  SYMBOLS =
    Realm.strings.permutation(4).map(&:join).collect do |str|
      "i#{str}j".insert(3, 'pe').to_sym
    end
  ALL = SYMBOLS.collect { |symbol| new symbol }

  def subtypes = string.scan(/../).collect { |x| Subtype.find(x) }
  def ordered_subtypes = subtypes.values_at(*SO)
  def realms = ordered_subtypes.map(&:realm)

  def description = subtypes.map(&:short_words).and

  def title = ordered_subtypes.join('•')
  alias link :title

  def types = Type.with(subtypes)

  def self.sort_by(string)
    mood_index = Mood.subtype_order.map(&:string).index(string)
    ALL.sort_by { |x| x.realms[mood_index] }
  end

  def self.min_by(string) = sort_by(string).first

  def self.find_by(ary)
    ALL.find { |x| (ary - x.subtypes).empty? }
  end
end
