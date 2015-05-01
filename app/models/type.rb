class Type

  def initialize(string)
    @path = string
  end
  attr_reader :path

  def behaviors; path.scan(/../).collect{|x| Behavior.find(x)}; end

  def self.my_path; "fbgceahd"; end
  def self.my_type; Type.new(my_path); end

  def subtypes; behaviors.add(Priority.all); end
  def behaviors_descending; behaviors.sort_by{|b| b.attitude.index}; end
  def personality_string; behaviors_descending.map(&:realm).map(&:letter).join; end
  def personality; Personality.find(personality_string); end

  def mbtis; behaviors.map(&:mbti).join("-"); end

  def dominant; subtypes.first; end
  def auxiliary; subtypes.second; end
  def tertiary; subtypes.third; end
  def inferior; subtypes.fourth; end

  def first_try; (dominant.mbti + auxiliary.mbti).mbti_order; end
  def second_try; (dominant.mbti + tertiary.mbti).mbti_order; end
  def last_try; (dominant.mbti + inferior.mbti).mbti_order; end
  MBTIS = %w{ISFP ISFJ ISTP ISTJ INFP INFJ INTP INTJ ESFP ESFJ ESTP ESTJ ENFP ENFJ ENTP ENTJ}
  def mbti?; MBTIS.include?(first_try); end
  def mbti;
    [first_try, second_try, last_try].each do |try|
      return try if MBTIS.include?(try)
    end
  end

  def behaviors_without(behavior)
    behaviors.reject{|b| b == behavior}
  end
  def q4_path_without(behavior); "Q4_#{behaviors_without(behavior).map(&:letters).join}"; end
  def q5_path; "Q5_#{behaviors.map(&:letters).join}"; end

  def ==(another); another.path == self.path; end
  def alternatives; personality.types; end
  def alternative_mbtis; alternatives.map(&:mbti).uniq; end

end
