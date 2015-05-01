class Subtype
  LETTERS = (Priority::LETTERS.product(Behavior::LETTERS)).map(&:join)

  def initialize(string)
    raise "#{string} isn't a Subtype" unless LETTERS.include?(string)
    @index = LETTERS.index(string)
    @letters = string
  end
  attr_reader :letters, :priority, :behavior

  SUBTYPES = LETTERS.collect{|choice| Subtype.new(choice)}
  def self.all; SUBTYPES; end

  def self.find(letters); SUBTYPES[LETTERS.index(letters)]; end

 def priority; Priority.find(letters[0]); end
 def behavior; Behavior.find(letters[1,2]); end

  def wing?(subtypes)
    subtypes.each{|s| return true if s.priority == self.priority}
    subtypes.each{|s| return true if s.behavior == self.behavior}
    return false
  end

  def behavior_letters; behavior.letters; end
  def alternatives; Priority.all.collect{|p| Subtype.find(p.letter + behavior_letters)};end

  delegate :mbti, :realm, :attitude, to: :behavior

  def function; realm.mbti; end

end
