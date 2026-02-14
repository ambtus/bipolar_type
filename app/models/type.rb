# frozen_string_literal: true

class Type < Concept
  SYMBOLS = Realm.all.permutation(4).collect do |realms|
      realms.join.to_sym
  end

  ALL = SYMBOLS.collect { |symbol| new symbol }

  class << self
    def my_path = Realm.mine.join
    def mine = find(my_path)
    def find_by_chosen(ary) = Type.find ary.sort_by(&:second).map(&:first).rotate.join
  end

  def realms = string.chars.collect { |x| Realm.find x }
  def title = realms.map(&:name).join(' • ')

  def e = "explore the #{realms.second.targets}"
  def i = "rest your #{realms.fourth.aspect}"
  def p = "fuel your #{realms.first.aspect}"
  def j = "control the #{realms.third.targets}"

end
