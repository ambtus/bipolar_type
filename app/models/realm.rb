class Realm
  LETTERS = %w{n t s f}

  def initialize(string)
    raise "#{string} isn't an Realm" unless LETTERS.include?(string)
    @index = LETTERS.index(string)
    @letter = string
  end
  attr_reader :letter, :index

  REALMS = LETTERS.collect{|letter| Realm.new(letter)}
  def self.all; REALMS; end
  def self.find(letter); REALMS[LETTERS.index(letter)]; end

  def +(attitude); State.find(attitude.letter + letter); end
  def states; Attitude.all.add(self); end

  def mbti; letter.upcase; end
  def with_mbti; "(#{mbti})"; end

  def adjective; %w{mental financial physical emotional}[@index]; end
  def adverb; adjective + "ly"; end
  def gain; %w{see earn eat hear}[@index]; end
  def energy; %w{colors dividends carbs tragedies}[@index]; end
  def strength; %w{shapes interest protein happy\ endings}[@index]; end
  def use_energy; %w{synthesize spend move emote}[@index]; end

  def short; adjective; end

  def extroverted; "needs to #{use_energy}"; end
  def manic; "wants to #{use_energy}"; end
  def depressed; "wants to #{gain} #{energy}"; end
  def introverted; "needs to #{gain} #{strength}"; end


  private
  def method_missing(method, *args, &block)
    if method.to_s =~ /^(.*)_with_mbti$/
      [self.send($1, *args, &block), with_mbti].join(" ")
    else
      super
    end
  end

end
