class Type

  def initialize(string)
    @path = string
    @behaviors = string.scan(/../).collect{|x| Behavior.find(x)}
  end
  attr_reader :path, :behaviors

  def self.my_path; "gbechafd"; end
  def self.my_type; Type.new(my_path); end

  def subtypes; @behaviors.add(Priority.all); end
  def behaviors_descending; @behaviors.sort_by{|b| b.attitude.index}; end
  def personality_string; behaviors_descending.map(&:realm).map(&:letter).join; end
  def personality; Personality.find(personality_string); end

  def mbtis; behaviors.map(&:mbti).join("-"); end

  def dominant; subtypes.first; end
  def auxiliary; subtypes.second; end
  def tertiary; subtypes.third; end
  def inferior; subtypes.fourth; end

  def fla; (dominant.mbti + auxiliary.function).mbti_order; end
  MBTIS = %w{ISFP ISFJ ISTP ISTJ INFP INFJ INTP INTJ ESFP ESFJ ESTP ESTJ ENFP ENFJ ENTP ENTJ}
  def mbti?; MBTIS.include?(fla); end
  def mbti;
    return fla if mbti?
    (dominant.mbti + tertiary.function).mbti_order
  end
  def with_mbti; "(#{mbti})"; end

  DYNAMICS = %w{IFP ISJ ITP INJ ESP EFJ ETJ ENP}
  def dynamic?
    return false unless DYNAMICS.include?(dominant.mbti)
    return false unless DYNAMICS.include?(auxiliary.mbti)
    dominant.mbti.last == auxiliary.mbti.last
  end


  def behaviors_without(behavior)
    behaviors.reject{|b| b == behavior}
  end
  def q4_path_without(subtype); "Q4_#{behaviors_without(subtype).map(&:letters).join}"; end
  def q5_path; "Q5_#{behaviors.map(&:letters).join}"; end

  def ==(another); another.path == self.path; end
  def alternatives; personality.types; end
  def alternative_mbtis; alternatives.map(&:mbti).uniq; end

  def states; subtypes.map(&:state); end
  def current_state; states.first; end
  def also_state; states.second; end
  def bad_states; states[0,2]; end
  def good_states; states[2,2]; end
  def traits; subtypes.map(&:trait); end

  def ideal_subtypes; behaviors.collect{|b| b + Priority.ideal}; end
  def ideal_states; ideal_subtypes.map(&:state); end
  def ideal_state; tertiary.state; end
  def non_ideal_states; states - [ideal_state]; end
end
