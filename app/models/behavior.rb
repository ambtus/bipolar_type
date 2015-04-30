class Behavior
  LETTERS = (Attitude::LETTERS.product(Realm::LETTERS)).map(&:join)

  def initialize(string)
    @index = LETTERS.index(string)
    raise "#{string} isn't a Behavior" unless @index
    @letters = string
    @attitude = Attitude.find(letters[0])
    @realm = Realm.find(letters[1])
  end
  attr_reader :letters, :attitude, :realm

  BEHAVIORS = LETTERS.collect{|choice| Behavior.new(choice)}
  def self.all; BEHAVIORS; end

  def self.find(letters); BEHAVIORS[LETTERS.index(letters)]; end

  def wing?(subtypes)
    subtypes.each{|s| return true if s.attitude == self.attitude}
    subtypes.each{|s| return true if s.realm == self.realm}
    return false
  end

  def subtypes; Subtype.all.select{|s| s.behavior == self}; end

  def description; [attitude.adjective, realm.adjective, attitude.noun].map(&:capitalize).join; end
  def mbti; [@attitude.mbti, @realm.mbti].join.mbti_order; end
  def with_mbti; "(#{mbti})"; end
  def description_with_mbti; [description, with_mbti].join(" "); end

  def get_or_use; attitude.get? ? realm.get : realm.use; end
  def trait; attitude.trait(get_or_use); end

  def default_state; attitude.too_full? ? "too #{realm.full}" : realm.empty; end

  def +(priority); Subtype.find(priority.letter + self.letters); end

end
