# frozen_string_literal: true

class Nature < Concept
  SYMBOLS =
    Realm.strings.permutation(4).map(&:join).collect do |str|
      "i#{str}j".insert(3, 'pe').to_sym
    end
  ALL = SYMBOLS.collect { |symbol| new symbol }

  def subtypes = string.scan(/../).collect { |x| Subtype.find(x) }
  def realms = subtypes.map(&:realm)

  def description = subtypes.map(&:short_words).and

  def title = subtypes.and
  alias link :title

  def types = Type.with(subtypes)

  def self.sort_by(string)
    mood_index = Mood.subtype_order.map(&:string).index(string)
    ALL.sort_by { |x| x.realms[mood_index] }
  end

  def self.min_by(string) = sort_by(string).first

  def self.find_by(ary)
    ALL.find{|x| x.subtypes.sort == ary.sort}
  end
end
