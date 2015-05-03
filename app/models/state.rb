class State
  LETTERS = Attitude::LETTERS.product(Realm::LETTERS).map(&:join)

  def initialize(string)
    raise "#{string} isn't a State" unless LETTERS.include?(string)
    @index = LETTERS.index(string)
    @letters = string
    @attitude_letters = string[0,2]
    @realm_letter = string[2]
  end
  attr_reader :letters

  STATES = LETTERS.collect{|choice| State.new(choice)}
  def self.all; STATES; end
  def self.find(letters); STATES[LETTERS.index(letters)]; end

  def lower; State.find(attitude.lower.letters + @realm_letter); end
  def opposite; State.find(attitude.opposite.letters + @realm_letter); end
  def higher; State.find(attitude.higher.letters + @realm_letter); end

  def mbti; letters.mbti_order.upcase; end

  def attitude; Attitude.find(@attitude_letters); end
  def realm; Realm.find(@realm_letter); end

  def generic; [realm.short, attitude.short].join(" "); end
  def with_mbti; "(#{mbti})"; end
  def generic_with_mbti; [short, with_mbti].join(" "); end
  def behavior; realm.send(attitude.short); end
  def behavior_with_mbti; [behavior, with_mbti].join(" "); end
  def short; [generic, behavior].join(": "); end
  def short_with_mbti; [short, with_mbti].join(" "); end

  def input_or_output; attitude.introverted? ? "input" : "output"; end
  def issue; realm.send(input_or_output); end
  def long; attitude.weak? ? "#{issue} too much" : "cannot stop #{issue.ing}"; end
  def long_with_mbti; [short, with_mbti].join(" "); end

  private
  def method_missing(method, *args, &block)
    realm.send(method, *args, &block)
  end
end
