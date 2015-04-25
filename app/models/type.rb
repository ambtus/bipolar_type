class Type

  def initialize(string)
    @path = string
    @subtypes = string.scan(/../).collect{|x| Subtype.find(x)}
  end

  attr_reader :path, :subtypes

  def mbtis; subtypes.map(&:mbti).join("-"); end

  def dominant; subtypes.first; end
  def auxiliary; subtypes.second; end
  def tertiary; subtypes.third; end
  def inferior; subtypes.fourth; end

  def mbti; (dominant.mbti + auxiliary.realm.mbti).mbti_order; end

  MBTIS = %w{ISFP ISFJ ISTP ISTJ INFP INFJ INTP INTJ ESFP ESFJ ESTP ESTJ ENFP ENFJ ENTP ENTJ}
  def mbti?; MBTIS.include?(mbti); end

  def closest;
    return false if mbti?
    (dominant.mbti + tertiary.realm.mbti).mbti_order
  end
end
