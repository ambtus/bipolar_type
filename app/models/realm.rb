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

  def output; %w{buy walk synthesize influence}[@index]; end
  def dom; %w{a\ borrower anorexic theoretical bossy}[@index]; end
  def top; %w{poor thin stupid homicidal}[@index]; end
  def bottom; %w{rich fat smart suicidal}[@index]; end
  def sub; %w{a\ lender obese critical submissive}[@index]; end
  def input; %w{work eat analyze empathize}[@index]; end
  def objective_measure; %w{bank\ statement mirror diploma stance}[@index]; end
  def top_or_bottom; [top, bottom].join(" or "); end

end
