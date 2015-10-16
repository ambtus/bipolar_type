# Encoding: utf-8
class Quad
  def self.my_path; Realm::LETTERS[1,4].join; end
  def self.first; Quad.find(my_path); end

  LETTERS = Realm::LETTERS[1,4].permutation(4).map(&:join)

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
  def ordered_subtypes; subtypes.values_at(1,3,0,2); end
  def name; subtypes.map(&:mbti).join("-");end

  Attitude::LETTERS.each_with_index { |path, index| define_method(path) {subtypes[index]}}

  def self.ordered
    every_sixth = 6.times.to_a.multiply([0,6,12,18]).flatten
    self.all.values_at(*every_sixth)
  end

end

