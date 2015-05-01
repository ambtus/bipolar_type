class Type
  LETTERS = Attitude::LETTERS.permutation(4).map(&:join)

  def initialize(string)
    raise "#{string} isn't a Type" unless LETTERS.include?(string)
    @index = LETTERS.index(string)
    @letters = string
  end
  attr_reader :letters

  TYPES = LETTERS.collect{|choice| Type.new(choice)}
  def self.all; TYPES; end

  def self.find(letters); TYPES[LETTERS.index(letters)]; end

  def attitudes; letters.scan(/./).collect{|l| Attitude.find(l)}; end
  def behaviors; attitudes.add(Realm.all).sort_by{|b| b.attitude.index}; end

  def mbti; behaviors.map(&:mbti).join("-"); end

  def manic_behaviors; behaviors[0,2]; end
  def manic_mbti; manic_behaviors.map(&:mbti).join.mbti_order; end

  def hypomanic_behaviors; [behaviors.first, behaviors.third]; end
  def hypomanic_mbti; hypomanic_behaviors.map(&:mbti).join.mbti_order; end

  def dysthymic_behaviors; [behaviors.second, behaviors.fourth]; end
  def dysthymic_mbti; dysthymic_behaviors.map(&:mbti).join.mbti_order; end

  def depressed_behaviors; [behaviors.third, behaviors.fourth]; end
  def depressed_mbti; depressed_behaviors.map(&:mbti).join.mbti_order; end
end
