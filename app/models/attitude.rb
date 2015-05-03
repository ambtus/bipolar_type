class Attitude
  LETTERS = %w{ep ej ip ij}

  def initialize(string)
    raise "#{string} isn't an Attitude" unless LETTERS.include?(string)
    @index = LETTERS.index(string)
    @letters = string
  end
  attr_reader :letters, :index

  ATTITUDES = LETTERS.collect{|letters| Attitude.new(letters)}
  def self.all; ATTITUDES; end
  def self.find(letters); ATTITUDES[LETTERS.index(letters)]; end

  def lower; Attitude.all[(@index + 1).modulo(4)]; end
  def opposite; Attitude.all[(@index + 2).modulo(4)]; end
  def higher; Attitude.all[(@index + 3).modulo(4)]; end

  def mbti; letters.upcase; end

  def +(realm); State.find(letters + realm.letter); end
  def states; Realm.all.add(self); end

  def short; %w{mania high low depression}[@index]; end
  def with_mbti; "(#{mbti})"; end
  def short_with_mbti; [short, with_mbti].join(" "); end

  def introverted?; @index > 1; end
  def weak?; [1,2].include?(@index); end

end
