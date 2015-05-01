class Behavior
  LETTERS = (Attitude::LETTERS.product(Realm::LETTERS)).map(&:join)

  def initialize(string)
    raise "#{string} isn't a Behavior" unless LETTERS.include?(string)
    @index = LETTERS.index(string)
    @letters = string
  end
  attr_reader :letters

  BEHAVIORS = LETTERS.collect{|choice| Behavior.new(choice)}
  def self.all; BEHAVIORS; end

  def self.find(letters); BEHAVIORS[LETTERS.index(letters)]; end

  def attitude; Attitude.find(letters[0]); end
  def realm; Realm.find(letters[1]); end

  def wing?(behaviors)
    behaviors.each{|b| return true if b.attitude == self.attitude}
    behaviors.each{|b| return true if b.realm == self.realm}
    return false
  end

  def subtypes; Subtype.all.select{|s| s.behavior == self}; end

  def mbti; [attitude.mbti, realm.mbti].join.mbti_order; end

  def +(priority); Subtype.find(priority.letter + self.letters); end

end
