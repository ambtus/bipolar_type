class Realm
  LETTERS = %w{a b c d}

  def initialize(string)
    @index = LETTERS.index(string)
    raise "#{string} isn't a Realm" unless @index
    @letter = string
  end
  attr_reader :letter

  REALMS = LETTERS.collect{|choice| Realm.new(choice)}
  def self.all; REALMS; end
  def self.find(letter); REALMS[LETTERS.index(letter)]; end

  def next; Realm.all[(@index + 1).modulo(4)]; end
  def previous; Realm.all[(@index + 3).modulo(4)]; end

  def mbti; %w{F S N T}[@index]; end
  def adjective; %w{interpersonal physical mental financial}[@index]; end
  def get; %w{cry eat analyze work}[@index]; end
  def what; %w{pity glycogen facts money}[@index]; end
  def use; %w{laugh walk synthesize buy}[@index]; end
  def too_full; %w{homicidal obese anxious rich}[@index]; end
  def too_empty; %w{suicidal anorexic bored destitute}[@index]; end


  def description; adjective.capitalize; end
  def with_mbti; "(#{mbti})"; end
  def description_with_mbti; [description, with_mbti].join(" "); end

  def self.getting; self.all.map(&:get).map(&:ing); end
  def self.depression; getting.collect{|g| "#{g} too much"}.to_sentence; end
  def self.using; self.all.map(&:use).map(&:ing); end
  def self.mania; using.collect{|u| "#{u} too much"}.to_sentence; end

  def get_and_or_use;  [get, use].join(" and/or "); end
  def getting_and_or_using;  [get, use].map(&:ing).join(" and/or "); end

  def full; "full of #{adjective} energy"; end
  def empty; "out of #{adjective} energy"; end
  def full_or_empty; "too much or too little #{adjective} energy"; end
  def balance; "balance #{adjective} energy by #{getting_and_or_using} more or less"; end

  def +(attitude); Behavior.find(attitude.letter + self.letter); end
  def behaviors; Attitude.all.collect{|a| self + a}; end
  def subtypes; Subtype.all.select{|s| s.realm == self}; end

end
