# Encoding: utf-8
class Quad
  def self.my_path; "tfns"; end
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
  def mbti; subtypes.map(&:mbti).join("‑"); end
  def names; subtypes.map(&:name); end
  def results; subtypes.map(&:result); end

  Attitude.all.each {|attitude| define_method(attitude.path) {subtypes[attitude.index]}}

  def official?; subtypes.each{|s| return false unless s.mbti.is_theoretical?}; end
  def self.officials; all.select{|q| q.official?}.sort_by{|q| q.mbti}; end

  def judging_subtypes; subtypes.select{|s| s.mbti.last == "J"}; end
  def perceiving_subtypes; subtypes.select{|s| s.mbti.last == "P"}; end
  def judging_letters; judging_subtypes.map(&:realm).to_mbti; end
def perceiving_letters; perceiving_subtypes.map(&:realm).to_mbti; end
  def mbtis
    ["I#{judging_letters}J", "E#{judging_letters}J", "I#{perceiving_letters}P", "E#{perceiving_letters}P", ]
  end

end

