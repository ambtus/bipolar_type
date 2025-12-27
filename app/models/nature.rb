# frozen_string_literal: true

class Nature < Concept
  SYMBOLS =
    Realm.all.permutation(4).collect do |realms|
      realms.map(&:string).join.to_sym
    end
  ALL = SYMBOLS.collect { |symbol| new symbol }

  def realms = string.scan(/./).collect { |x| Realm.find(x) }
  def subtypes = realms.add(Mood.nature_order)

  def description = subtypes.map(&:short_words).and

  def title = subtypes.join('•')
  alias link :title
  alias inspect :title

  def types = Type.with(subtypes)
  def bp1 = types.first
  def bp2 = types.second
end
