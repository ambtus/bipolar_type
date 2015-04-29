class Type

  def initialize(string)
    @path = string
    @subtypes = string.scan(/.../).collect{|x| Subtype.find(x)}.sort_by{|s| s.priority.index}
  end
  attr_reader :path, :subtypes

  def self.my_path; "ifbjgckealhd"; end
  def self.my_type; Type.new(my_path); end

  def mbtis; subtypes.map(&:mbti).join("-"); end


  MBTIS = %w{ISFP ISFJ ISTP ISTJ INFP INFJ INTP INTJ ESFP ESFJ ESTP ESTJ ENFP ENFJ ENTP ENTJ}

  def dominant; subtypes.first; end
  def auxiliary; subtypes.second; end
  def tertiary; subtypes.third; end

  def mbti; (dominant.tla + auxiliary.function).mbti_order; end
  def with_mbti; "(#{mbti})"; end
  def mbti?; MBTIS.include?(mbti); end

  def closest;
    return nil if mbti?
    (dominant.tla + tertiary.function).mbti_order
  end

  DYNAMICS = %w{IFP ISJ ITP INJ ESP EFJ ETJ ENP}
  def dynamic?
    return false unless DYNAMICS.include?(dominant.tla)
    return false unless DYNAMICS.include?(auxiliary.tla)
    dominant.tla.last == auxiliary.tla.last
  end


  def subtypes_without(subtype); subtypes - [subtype];end
  def string_without(subtype); subtypes_without(subtype).map(&:letters).join; end
  def q4_path_without(subtype)
    raise "not my subtype" unless subtypes.include?(subtype)
    "Q4_#{string_without(subtype)}"
  end


  def attitude_functions; subtypes.map(&:attitude_function); end
  def alternative_attitude_functions; attitude_functions.permutation(4).to_a - [attitude_functions]; end
  def alternative_type_strings;
    alternative_attitude_functions.collect do |attitude_functions|
      Priority::LETTERS.each_with_index.collect do |priority, index|
        priority + attitude_functions[index]
      end.join
    end
  end
  def alternatives; alternative_type_strings.collect{|a| Type.new(a)}; end

  def states; subtypes.map(&:state); end
  def bad_states; states[0,2]; end
  def good_states; states[2,2]; end
  def traits; subtypes.map(&:trait); end
end
