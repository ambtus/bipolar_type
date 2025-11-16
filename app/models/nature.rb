# frozen_string_literal: true

class Nature < Concept
    SYMBOLS =
      Realm.strings.permutation(4).map(&:join).collect do |str|
        str = "i#{str}j".insert(3, 'pe')
      end
  ALL = SYMBOLS.collect { |symbol| new symbol }

  def subtypes = string.scan(/../).collect { |x| Subtype.find(x) }
  def description = subtypes.map(&:word).and

  def types = Type.with(subtypes)
end
