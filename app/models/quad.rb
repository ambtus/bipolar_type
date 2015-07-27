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
  def actions; subtypes.map(&:action); end
  def mbti; subtypes.map(&:mbti).join("‑"); end

  def type_paths;
    [
      realm_letters.values_at(0,1).join,
      realm_letters.values_at(1,0).join,
      realm_letters.values_at(0,2).join,
      realm_letters.values_at(1,3).join,
      realm_letters.values_at(2,0).join,
      realm_letters.values_at(3,1).join,
      realm_letters.values_at(2,3).join,
      realm_letters.values_at(3,2).join,
    ].add(path)
  end

  def types; type_paths.collect{|l| Type.find(l)}; end

  def mbtis; types.map(&:mbti); end

  def e; "E" + realms.values_at(0,1).to_mbti + ": " + actions.values_at(0,1).join(" & "); end
  def p; realms.values_at(0,2).to_mbti + "P: " + actions.values_at(0,2).join(" & "); end
  def j; realms.values_at(1,3).to_mbti + "J: " + actions.values_at(1,3).join(" & "); end
  def i; "I" + realms.values_at(2,3).to_mbti + ": " + actions.values_at(2,3).join(" & "); end

end

