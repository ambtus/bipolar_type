# frozen_string_literal: true

class Type < Concept
  SYMBOLS = Realm.all.permutation(4).collect do |realms|
      realms.join.to_sym
  end

  ALL = SYMBOLS.collect { |symbol| new symbol }

  class << self
    def my_path = Realm.mine.join
    def mine = find(my_path)
    def find_by_greens(ary) = ALL.find {|x| (x.greens - ary).blank?}
  end

  def realms = string.chars.collect { |x| Realm.find x }
  def greens = Action.all.add(realms)
  def reds = greens.map(&:opposite)

  def title = greens.join('•')

end
