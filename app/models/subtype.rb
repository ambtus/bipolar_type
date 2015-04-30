class Subtype
  LETTERS = (Priority::LETTERS.product(Behavior::LETTERS)).map(&:join)

  def initialize(string)
    @index = LETTERS.index(string)
    raise "#{string} isn't a Subtype" unless @index
    @letters = string
    @priority = Priority.find(letters[0])
    @behavior = Behavior.find(letters[1,2])
  end
  attr_reader :letters, :priority, :behavior

  SUBTYPES = LETTERS.collect{|choice| Subtype.new(choice)}
  def self.all; SUBTYPES; end

  def self.find(letters); SUBTYPES[LETTERS.index(letters)]; end

  def wing?(subtypes)
    subtypes.each{|s| return true if s.priority == self.priority}
    return true if @behavior.wing?(subtypes)
    return false
  end

  def behavior_letters; @behavior.letters; end
  def alternatives; Priority.all.collect{|p| Subtype.find(p.letter + behavior_letters)};end

  delegate :mbti, :default_state, :trait, :attitude, :realm, :aka, to: :behavior
  delegate :now_or_never, :because_or_although, to: :priority

  def function; realm.mbti; end

  def description; [priority.description, behavior.description].join; end
  def mbti_with_priority; [@priority.mbti, mbti].join(" "); end
  def with_mbti; "(#{mbti_with_priority})"; end
  def description_with_mbti; [description, with_mbti].join(" "); end

  def state; "#{now_or_never} #{default_state}"; end

  def short; "I am #{state}"; end

end
