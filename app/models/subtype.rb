class Subtype
  LETTERS = Priority::LETTERS.product((Attitude::LETTERS.product(Realm::LETTERS))).map(&:join)

  def initialize(string)
    @index = LETTERS.index(string)
    raise "#{string} isn't a Subtype" unless @index
    @letters = string
    @priority = Priority.find(letters[0])
    @attitude = Attitude.find(letters[1])
    @realm = Realm.find(letters[2])
  end
  attr_reader :letters, :priority, :attitude, :realm



  SUBTYPES = LETTERS.collect{|choice| Subtype.new(choice)}
  def self.all; SUBTYPES; end

  def self.find(letters); SUBTYPES[LETTERS.index(letters)]; end

  def wing?(subtypes)
    subtypes.each{|s| return true if s.priority == self.priority}
    subtypes.each{|s| return true if s.attitude == self.attitude}
    subtypes.each{|s| return true if s.realm == self.realm}
    return false
  end

  def attitude_function; @letters[1,2]; end
  def alternatives; Priority.all.collect{|p| Subtype.find(p.letter + attitude_function)};end

  def description; [priority.description, attitude.adjective.capitalize, realm.description, attitude.noun.capitalize].join; end
  def mbti; [@attitude.mbti, @realm.mbti].join.mbti_order; end
  def mbti_with_priority; [@priority.mbti, mbti].join(" "); end
  def with_mbti; "(#{mbti_with_priority})"; end
  def description_with_mbti; [description, with_mbti].join(" "); end
  delegate :function, to: :realm
  def tla; [@attitude.mbti, function].join.mbti_order; end

  delegate :now_or_never, :because_or_although, to: :priority

  def default_state; attitude.rational? ? realm.full : realm.empty;end
  def state; "#{now_or_never} too #{default_state}"; end
  def get_or_use; attitude.get? ? realm.get : realm.use; end
  def trait; attitude.trait(get_or_use); end

  def short; "I am #{state} #{because_or_although} I #{trait}"; end

  def short_with_mbti_first; "#{mbti}: #{short}"; end
  def short_with_mbti_last; "#{short} {#{mbti}}"; end

end
