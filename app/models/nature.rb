# frozen_string_literal: true

class Nature < Concept
  SYMBOLS =
    Realm.all.permutation(4).collect do |realms|
      realms.add(Mood.all).join.to_sym
    end
  ALL = SYMBOLS.collect { |symbol| new symbol }

  def subtypes = string.scan(/../).collect { |x| Subtype.find(x) }
  def realms = subtypes.map(&:realm)

  def description = subtypes.map(&:short_words).and

  def title = subtypes.join('•')
  alias link :title
  alias inspect :title

  def types = Type.with(subtypes)

  def self.sort_by(string)
    mood_index = Mood.all.map(&:string).index(string)
    ALL.sort_by { |x| x.realms[mood_index] }
  end

  def self.find_by(ary)
    ALL.find { |x| (ary - x.subtypes).empty? }
  end
end
