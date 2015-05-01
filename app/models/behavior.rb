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

  def realm_adjective; realm.short; end

  def generic; [realm.short, attitude.short].join(" "); end
  def short; "#{generic}: #{aka}"; end
  def with_mbti; "(#{mbti})"; end
  def short_with_mbti; [short, with_mbti].join(" "); end
  def aka_with_mbti; [aka, with_mbti].join(" "); end

  def aka
    case generic
    when "financial output"
      "spend rewards (buy goods and services)"
    when "mental output"
      "synthesize (put the puzzles together)"
    when "physical output"
      "walk (burn calories)"
    when "interpersonal output"
      "emote (win friends and influence people)"
    when "financial steady"
      "lots of small earnings and expenditures"
    when "mental steady"
      "lots of small problems and puzzles"
    when "physical steady"
      "lots of small meals and short walks"
    when "interpersonal steady"
      "lots of short stories and songs"
    when "financial bursty"
      "a few large earnings and expenditures"
    when "mental bursty"
      "a few large problems and puzzles"
    when "physical bursty"
      "a few large meals and long walks"
    when "interpersonal bursty"
      "a few long novels and concerts"
    when "financial input"
      "earn rewards (work or compete)"
    when "mental input"
      "analyze (take the puzzles apart)"
    when "physical input"
      "eat (consume calories)"
    when "interpersonal input"
      "listen (understand people)"
    end
  end
end
