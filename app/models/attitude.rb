class Attitude
  LETTERS = %w{e p j i}

  def initialize(string)
    raise "#{string} isn't an Attitude" unless LETTERS.include?(string)
    @index = LETTERS.index(string)
    @letter = string
  end
  attr_reader :letter, :index

  ATTITUDES = LETTERS.collect{|letter| Attitude.new(letter)}
  def self.all; ATTITUDES; end
  def self.find(letter); ATTITUDES[LETTERS.index(letter)]; end

  def self.all_reordered; [all.third, all.first, all.last, all.second]; end

  def lower; Attitude.all[(@index + 1).modulo(4)]; end
  def opposite; Attitude.all[(@index + 2).modulo(4)]; end
  def higher; Attitude.all[(@index + 3).modulo(4)]; end

  def mbti; letter.upcase; end

  def +(realm); State.find(letter + realm.letter); end
  def states; Realm.all.add(self); end

  def short; %w{top sub dom bottom}[@index]; end
  def with_mbti; "(#{mbti})"; end
  def short_with_mbti; [episode, with_mbti].join(" "); end

  def chronic?; [1,2].include?(@index); end
  def mania?; @index.even?; end
  def acute_or_chronic; chronic? ? "chronic" : "acute"; end
  def mania_or_depression; mania? ? "mania" : "depression"; end
  def episode; [acute_or_chronic, mania_or_depression].join(" "); end

end
