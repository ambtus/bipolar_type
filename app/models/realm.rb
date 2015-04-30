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

  def subtypes; Subtype.all.select{|s| s.realm == self}; end

  def neuro; %w{dopamine serotonin GABA oxytocin}[@index]; end
  def neuro_up; neuro.slice(0).upcase + neuro.slice(1..-1); end

  def adjective; %w{financial physical mental emotional}[@index]; end
  def description; adjective.capitalize; end
  def mbti; %w{T S N F}[@index]; end
  def with_mbti; "(#{mbti})"; end
  def description_with_mbti; [description, with_mbti].join(" "); end

  def get; %w{work eat look listen}[@index]; end
  def use; %w{spend move think emote}[@index]; end

  def organ; %w{hands mouth eyes ears}[@index]; end
  def use_with; "#{get} with your #{organ}"; end

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

end
