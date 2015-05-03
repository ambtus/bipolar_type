class Attitude
  LETTERS = %w{e j i p}
  def opposite_letter; %w{i p e j}[@index]; end

  def initialize(string)
    raise "#{string} isn't an Attitude" unless LETTERS.include?(string)
    @index = LETTERS.index(string)
    @letter = string
  end
  attr_reader :letter, :index

  ATTITUDES = LETTERS.collect{|choice| Attitude.new(choice)}
  def self.all; ATTITUDES; end

  def self.find(letter); ATTITUDES[LETTERS.index(letter)]; end

  def next; Attitude.all[(@index + 1).modulo(4)]; end
  def previous; Attitude.all[(@index + 3).modulo(4)]; end

  def opposite; Attitude.find(opposite_letter); end

  def bias_letters; LETTERS - [letter, opposite_letter]; end
  def biases; bias_letters.collect{|l| Attitude.find(l)}; end

  def mbti; letter.upcase; end

  def +(realm); Trait.find(realm.letter + self.letter); end
  def traits; Realm.all.add(self); end

  def short; %w{output steadiness input burstiness}[@index]; end
  def with_mbti; "(#{mbti})"; end
  def short_with_mbti; [short, with_mbti].join(" "); end

  def adjective; %w{extroverted steady introverted bursty}[@index]; end

end
