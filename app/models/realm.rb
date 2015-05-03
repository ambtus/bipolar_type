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

  def +(attitude); State.find(attitude.letters + letter); end
  def states; Attitude.all.add(self); end

  def short; %w{financial physical mental interpersonal}[@index]; end
  def with_mbti; "(#{mbti})"; end
  def short_with_mbti; [short, with_mbti].join(" "); end

  def output; %w{buy walk synthesize talk}[@index]; end
  def mania; %w{in\ debt anorexic an\ idiot homicidal}[@index]; end
  def high; %w{poor thin stupid dominant}[@index]; end
  def low; %w{rich fat smart submissive}[@index]; end
  def depression; %w{a\ lender obese a\ genius suicidal}[@index]; end
  def input; %w{work eat analyze listen}[@index]; end
  def objective_measure; %w{bank\ statement mirror diploma job\ title}[@index]; end
  def high_or_low; [high, low].join(" or "); end

end
