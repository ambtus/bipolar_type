class Realm
  LETTERS = %w{a b c d}

  def initialize(string)
    raise "#{string} isn't a Realm" unless LETTERS.include?(string)
    @index = LETTERS.index(string)
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
  def energy; %w{pity fat knowledge money}[@index]; end
  def empty; %w{unhappy hungry clueless driven}[@index]; end 
  def full; %w{pitied fat smart rich}[@index]; end
  def get; %w{cry eat learn work}[@index]; end
  def essential; %w{smile walk decide buy\ tools}[@index]; end
  def waste; %w{laugh exercise teach buy\ toys}[@index]; end

  def description; adjective.capitalize; end
  def with_mbti; "(#{mbti})"; end
  def description_with_mbti; [description, with_mbti].join(" "); end

  def +(attitude); Behavior.find(attitude.letter + self.letter); end
  def behaviors; Attitude.all.collect{|a| self + a}; end
  def subtypes; Subtype.all.select{|s| s.realm == self}; end

end
