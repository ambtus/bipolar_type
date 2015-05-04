class Realm
  LETTERS = %w{t s n f}

  def initialize(string)
    raise "#{string} isn't an Realm" unless LETTERS.include?(string)
    @index = LETTERS.index(string)
    @letter = string
  end
  attr_reader :letter

  REALMS = LETTERS.collect{|letter| Realm.new(letter)}
  def self.all; REALMS; end
  def self.find(letter); REALMS[LETTERS.index(letter)]; end

  def mbti; letter.upcase; end

  def +(attitude); State.find(attitude.letter + letter); end
  def states; Attitude.all.add(self); end

  def short; %w{financial physical mental emotional}[@index]; end
  def with_mbti; "(#{mbti})"; end
  def short_with_mbti; [short, with_mbti].join(" "); end

  def empty; %w{poor anorexic stupid dominant}[@index]; end
  def underfull; %w{lower-middle-class thin wrong homicidal}[@index]; end
  def overfull; %w{upper-middle-class fat right suicidal}[@index]; end
  def stuffed; %w{rich obese smart submissive}[@index]; end

  def objective_measures; %w{bank\ statements mirrors made\ mistakes plans}[@index]; end

  def input; %w{work eat analyze understand}[@index]; end
  def large; %w{80-dollar 2100-calorie 1000-piece 3-viewpoint}[@index];end
  def small; %w{27-dollar 700-calorie 300-piece 1-viewpoint}[@index];end
  def chunk; %w{hour meal puzzle story}[@index];end
  def chunks; chunk.pluralize; end
  def output; %w{buy move synthesize influence}[@index]; end
end
