# frozen_string_literal: true

class Type < Concept
  SYMBOLS = Realm.all.permutation(4).collect do |realms|
    realms.join_strings(Mood.all).join.to_sym
  end.flatten

  ALL = SYMBOLS.collect { |symbol| new symbol }

  class << self
    def find_by(hash) = ALL.find { |s| (hash[:subtypes] - s.subtypes).blank? }
    def with_subtypes(subtypes) = ALL.reject { |s| (subtypes - s.subtypes).present? }
    def my_path = :FpTeNjSi
    def my_type = Type.find(my_path)
    # for cucumber tests, just needs to be different.
    def your_path = :NpSeTjFi
    def your_type = Type.new(your_path)
    # for visual tests, want to hit all sixteen subtypes
    def next_path = :TpFeSjNi
    def other_path = :SpNeFjTi
  end

  def subtypes = string.scan(/../).collect { |x| Subtype.find(x) }
  def realms = string.scan(/../).map(&:first).collect { |x| Realm.find(x) }

  def left = subtypes.first
  def top = subtypes.second
  def right = subtypes.third
  def bottom = subtypes.fourth
end
