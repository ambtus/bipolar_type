class Behavior
  # LETTERS = (Realm::LETTERS.product(State::LETTERS)).map(&:join)
  LETTERS = ["tep", "tej", "sep", "sej",
             "tip", "tij", "sip", "sij",
             "nep", "nej", "fep", "fej",
             "nip", "nij", "fip", "fij"]


  def initialize(string)
    raise "#{string} isn't a Behavior" unless LETTERS.include?(string)
    @index = LETTERS.index(string)
    @letters = string
    @realm_letter = string[0]
    @state_letters = string[1,2]
  end
  attr_reader :letters

  BEHAVIORS = LETTERS.collect{|choice| Behavior.new(choice)}
  def self.all; BEHAVIORS; end

  def self.find(letters); BEHAVIORS[LETTERS.index(letters)]; end

  def realm; Realm.find(@realm_letter); end
  def state; State.find(@state_letters); end

  def mbti; @letters.mbti_order.upcase; end

  def generic; [state.adjective, realm.short, state.noun].join(" "); end
  def short; [generic, aka].join(": "); end
  def with_mbti; "(#{mbti})"; end
  def short_with_mbti; [short, with_mbti].join(" "); end

  def modifier; state.adjective == "steady" ? "many" : "a few"; end
  def size; state.adjective == "steady" ? (state.noun == "output" ? realm.small_output : realm.small_input) : (state.noun == "output" ? realm.big_output : realm.big_input); end

  def verb; state.noun == "output" ? realm.output : realm.input; end
  def noun; state.noun == "output" ? realm.productions : realm.resources; end
  def aka; [verb, modifier, size, noun].join(" "); end
  def aka_with_mbti; [aka, with_mbti].join(" "); end

end
