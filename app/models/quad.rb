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

  def sensitivity; Sensitivity.find(@path.first); end

  def realm_path; @path.chip; end
  def realms; realm_path.scan(/./).collect{|p| Realm.find(p)}; end

  def dominant; realms.first + sensitivity; end
  def secondary; realms.second + sensitivity.opposite; end
  def tertiary; realms.third + sensitivity; end
  def inferior; realms.fourth + sensitivity.opposite; end

  def subtypes; [dominant,secondary,tertiary,inferior]; end

  def name; subtypes.map(&:short_name).join; end
  def long_name; subtypes.map(&:name).join(", "); end

  def mbti
    case name
    when "TeFiNeSi", "TeSiFeNi", "TeSiNeFi"
      "ESTJ"
    when "TeFiSeNi", "TeNiFeSi", "TeNiSeFi"
      "ENTJ"
    when "FeTiNeSi", "FeSiTeNi", "FeSiNeTi"
      "ESFJ"
    when "FeTiSeNi", "FeNiTeSi", "FeNiSeTi"
      "ENFJ"
    when "NeTiFeSi", "NeTiSeFi", "NeSiFeTi"
      "ENTP"
    when "NeFiTeSi", "NeFiSeTi", "NeSiTeFi"
      "ENFP"
    when "SeTiFeNi", "SeTiNeFi", "SeNiFeTi"
      "ESTP"
    when "SeFiTeNi", "SeFiNeTi", "SeNiTeFi"
      "ESFP"
    when "TiFeNiSe", "TiSeFiNe", "TiSeNiFe"
      "ISTP"
    when "TiFeSiNe", "TiNeFiSe", "TiNeSiFe"
      "INTP"
    when "FiTeNiSe", "FiSeTiNe", "FiSeNiTe"
      "ISFP"
    when "FiTeSiNe", "FiNeTiSe", "FiNeSiTe"
      "INFP"
    when "NiTeFiSe", "NiTeSiFe", "NiSeFiTe"
      "INTJ"
    when "NiFeTiSe", "NiFeSiTe", "NiSeTiFe"
      "INFJ"
    when "SiTeFiNe", "SiNeFiTe", "SiFeNiTe"
      "ISTJ"
    when "SiFeTiNe", "SiNeTiFe", "SiTeNiFe"
      "ISFJ"
    end
  end

end
