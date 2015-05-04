class State
  LETTERS = Attitude::LETTERS.product(Realm::LETTERS).map(&:join)

  def initialize(string)
    raise "#{string} isn't a State" unless LETTERS.include?(string)
    @index = LETTERS.index(string)
    @letters = string
    @attitude_letter = string[0]
    @realm_letter = string[1]
  end
  attr_reader :letters

  STATES = LETTERS.collect{|choice| State.new(choice)}
  def self.all; STATES; end
  def self.find(letters); STATES[LETTERS.index(letters)]; end

  def self.all_reordered; Attitude.all_reordered.multiply(Realm.all).flatten; end

  def lower; State.find(attitude.lower.letter + @realm_letter); end
  def opposite; State.find(attitude.opposite.letter + @realm_letter); end
  def higher; State.find(attitude.higher.letter + @realm_letter); end

  def mbti; letters.mbti_order.upcase; end

  def attitude; Attitude.find(@attitude_letter); end
  def realm; Realm.find(@realm_letter); end


  def generic; [attitude.acute_or_chronic, realm.short, attitude.mania_or_depression].join(" "); end
  def with_mbti; "(#{mbti})"; end
  def generic_with_mbti; [generic, with_mbti].join(" "); end
  def state; realm.send(attitude.state); end
  def behavior_with_mbti; [state, with_mbti].join(" "); end
  def short; [generic, state, issue].join(" — "); end
  def short_with_mbti; [short, with_mbti,].join(" "); end
  def short_without_generic; [state, issue].join(" — "); end

  def issue
    case attitude.mbti
    when "E"
      "cannot #{realm.input} enough"
    when "P"
      "#{realm.input} too much"
    when "J"
      "#{realm.output} too much"
    when "I"
      "cannot #{realm.output} enough"
    end
  end
  def issue_with_mbti; [issue, with_mbti,].join(" "); end

  def problem
    case attitude.index
    when 0
      "you are #{input.ing} three #{large} #{chunks}"
    when 1
      "you are #{input.ing} three #{small} #{chunks}"
    when 2
      "you are #{input.ing} one #{large} #{chunk}"
    when 3
      "you are #{input.ing} one #{small} #{chunk}"
    end
  end

  def solution; attitude.one? ? "you need to #{input} one #{large} #{chunk}" : "you need to #{input} three #{small} #{chunks}"; end

  private
  def method_missing(method, *args, &block)
    realm.send(method, *args, &block)
  end

end
