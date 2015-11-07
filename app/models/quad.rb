# Encoding: utf-8
class Quad
  def self.my_path; "i" + Realm::LETTERS.join; end
  def self.first; Quad.find(my_path); end

  LETTERS = Sensitivity::LETTERS.multiply(Realm::LETTERS.permutation(4).map(&:join)).flatten

  def initialize(letters)
    @path = letters
    @index = LETTERS.index(letters)
  end
  attr_reader :path

  QUADS = LETTERS.collect{|letters| Quad.new(letters)}
  def self.find(letters); QUADS[LETTERS.index(letters)]; end
  def self.all; QUADS; end

  def i?; path.first == "i"; end

  def realms; @path.chip.scan(/./).collect{|p| Realm.find(p)}; end

  def sensitives; realms[0,2].collect{|r| r + Sensitivity.i}; end
  def insensitives; realms[2,2].collect{|r| r + Sensitivity.e}; end
  def subtypes; [*sensitives, *insensitives]; end

  def dominant; i? ? sensitives.second : insensitives.first ; end
  def auxiliary; i? ? insensitives.first : sensitives.second ; end
  def tertiary; i? ? sensitives.first : insensitives.second ; end
  def inferior; i? ? insensitives.second : sensitives.first ; end

  def is_theoretical?; dominant.realm.perceiving? != auxiliary.realm.perceiving?; end

  def long_name; subtypes.map(&:name).join(", "); end
  def dominant_names; [dominant, auxiliary].map(&:name).join(" & "); end

  def functions; subtypes.map(&:function); end
  def name; functions.join; end

  def depressed_subtypes; [subtypes.first, subtypes.second.invert] + subtypes[2,2]; end
  def manic_subtypes; subtypes[0,2] + [subtypes.third.invert, subtypes.last]; end

  def find_mbti(subtypes); subtypes.map(&:function).join.to_word.mbti.fix(path.first); end
  def euthymic_mbti; find_mbti([dominant,auxiliary,inferior]); end
  def depressed_mbti; find_mbti(depressed_subtypes[0,3]); end
  def manic_mbti; find_mbti(manic_subtypes[1,3].reverse); end

  def mbtis; [manic_mbti, euthymic_mbti, depressed_mbti]; end

end
