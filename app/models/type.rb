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
    def your_path = my_type.suicidal_path
    def your_type = Type.new(your_path)
    # for visual tests, want to hit all sixteen subtypes
    def next_path = my_type.bipolar_path
    def other_path = my_type.neurotic_path
  end

  def subtypes = string.scan(/../).collect { |x| Subtype.find(x) }
  def realms = string.scan(/../).map(&:first).collect { |x| Realm.find(x) }

  def bipolar_path =  realms.values_at(3,0,1,2).join_strings(Mood.all).join
  def neurotic_path =  realms.values_at(1,2,3,0).join_strings(Mood.all).join
  def suicidal_path = realms.values_at(2,3,0,1).join_strings(Mood.all).join

  def firsts = subtypes.select(&:first?).map(&:mbti)
  def seconds = subtypes.select(&:second?).map(&:mbti)
  def possibles = firsts.multiply(seconds).flatten
  def true_mbtis = possibles.select{|x| x.is_mbti?}
  def reversed = possibles.map{|x| x.chars.values_at(0,2,1,3).join}
  def almost_mbtis = reversed.select{|x| x.is_mbti?}.map{|x| "~#{x}"}
  def mbtis = true_mbtis + almost_mbtis
  def mbti = mbtis.compact_blank.join('/')
end
