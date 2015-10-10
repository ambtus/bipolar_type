# Encoding: utf-8
class Quad
  def self.my_path; Realm::LETTERS.join; end
  def self.first; Quad.find(my_path); end

  LETTERS = Realm::LETTERS.permutation(4).map(&:join)

  def initialize(letters)
    raise "#{letters} isn't a Quad" unless LETTERS.include?(letters)
    @index = LETTERS.index(letters)
    @path = letters
  end
  attr_reader :path

  QUADS = LETTERS.collect{|letters| Quad.new(letters)}
  def self.all; QUADS; end
  def self.find(letters); QUADS[LETTERS.index(letters)]; end

  def realm_letters; path.scan(/./); end
  def realms; realm_letters.collect{|l| Realm.find(l)}; end
  def subtypes; realms.add(Attitude.all); end
  def mbti; subtypes.map(&:mbti).join("-"); end
  def names; subtypes.map(&:name); end

  def self.ordered
    every_sixth = 6.times.to_a.multiply([0,6,12,18]).flatten
    self.all.values_at(*every_sixth)
  end

  def mbtis; realms.add(Attitude.all.reverse).map(&:mbti); end

end

