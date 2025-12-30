# frozen_string_literal: true

class Type < Concept
  SYMBOLS =
    Realm.all.permutation(4).collect do |realms|
      realms.map(&:string).join.to_sym
    end
  ALL = SYMBOLS.collect { |symbol| new symbol }

  def realms = string.scan(/./).collect { |x| Realm.find(x) }
  def subtypes = realms.add(Mood.type_order)

  def description = subtypes.map(&:short_words).and

  def title = subtypes.join
  alias link :title
  alias inspect :title

  def types = Bipolar.with(subtypes)
  def left = types.first
  def right = types.second
end
