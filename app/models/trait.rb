class Trait
  LETTERS = ["te", "tj", "se", "sj",
             "tp", "ti", "sp", "si",
             "ne", "nj", "fe", "fj",
             "np", "ni", "fp", "fi"]

  def initialize(string)
    raise "#{string} isn't a Trait" unless LETTERS.include?(string)
    @index = LETTERS.index(string)
    @letters = string
    @realm_letter = string[0]
    @attitude_letter = string[1]
  end
  attr_reader :letters

  TRAITS = LETTERS.collect{|choice| Trait.new(choice)}
  def self.all; TRAITS; end

  def self.find(letters); TRAITS[LETTERS.index(letters)]; end

  def realm; Realm.find(@realm_letter); end
  def attitude; Attitude.find(@attitude_letter); end

  def next; realm + attitude.next; end
  def previous; realm + attitude.previous; end

  def next_subtype; Subtype.find(letters + attitude.next.letter); end
  def previous_subtype; Subtype.find(letters + attitude.previous.letter);end

  def mbti; @letters.mbti_order.upcase; end

  def generic; [realm.short, attitude.short].join(" "); end
  def short; [generic, aka].join(": "); end
  def with_mbti; "(#{mbti})"; end
  def short_with_mbti; [short, with_mbti].join(" "); end

  def aka
    case attitude.short
    when "steadiness"
      "many #{realm.small_input} #{realm.resources} and #{realm.small_output} #{realm.productions}"
    when "burstiness"
      "a few #{realm.big_input} #{realm.resources} and #{realm.big_output} #{realm.productions}"
    when "output"
      "#{realm.output} #{realm.big_output} and #{realm.small_output} #{realm.productions}"
    when "input"
      "#{realm.input} #{realm.big_input} and #{realm.small_input} #{realm.resources}"
    end
  end

  private
  def method_missing(sym, *args, &block)
    realm.send sym, *args, &block
  end

end
