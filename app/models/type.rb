# frozen_string_literal: true

class Type < Concept
  SYMBOLS = Realm.all.permutation(4).collect do |realms|
    Attitude.permutations.collect do |behaviors|
       realms.add(behaviors).map(&:string).join('•').to_sym
    end
  end.flatten

  ALL = SYMBOLS.collect { |symbol| new symbol }

  class << self
    def my_path = Realm.mine.add(Attitude.mine).map(&:symbol).join('•')
    def mine = find(my_path)
    def find_by_chosen(ary) = Type.find ary.sort_by(&:second).map(&:first).rotate.join
  end

  def subtypes = string.split('•').collect { |x| Subtype.find x }


  def e = "explore the #{realms.second.targets}"
  def i = "rest your #{realms.fourth.aspect}"
  def p = "fuel your #{realms.first.aspect}"
  def j = "control the #{realms.third.targets}"

end
