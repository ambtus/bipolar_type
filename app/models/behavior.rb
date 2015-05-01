class Behavior
  LETTERS = (Realm::LETTERS.product(Attitude::LETTERS)).map(&:join)

  def initialize(string)
    raise "#{string} isn't a Behavior" unless LETTERS.include?(string)
    @index = LETTERS.index(string)
    @letters = string
    @realm_letter = string[0]
    @attitude_letter = string[1]
  end
  attr_reader :letters, :realm_letter, :attitude_letter

  BEHAVIORS = LETTERS.collect{|choice| Behavior.new(choice)}
  def self.all; BEHAVIORS; end

  def self.find(letters); BEHAVIORS[LETTERS.index(letters)]; end

  def realm; Realm.find(realm_letter); end
  def attitude; Attitude.find(attitude_letter); end

  def mbti; @letters.mbti_order.upcase; end

  delegate :attitude_problems, to: :attitude

  def behavior_problems; attitude_problems.collect{|ap| ap + realm}; end

end
