class Attitude
  LETTERS = %w{e j p i}

  def initialize(string)
    raise "#{string} isn't an Attitude" unless LETTERS.include?(string)
    @index = LETTERS.index(string)
    @letter = string
  end
  attr_reader :letter, :index

  ATTITUDES = LETTERS.collect{|letter| Attitude.new(letter)}
  def self.all; ATTITUDES; end
  def self.find(letter); ATTITUDES[LETTERS.index(letter)]; end

  def +(realm); State.find(letter + realm.letter); end
  def states; Realm.all.add(self); end

  def mbti; letter.upcase; end
  def with_mbti; "(#{mbti})"; end

  def adjective; %w{  extroverted manic depressed introverted}[@index]; end

 def short; adjective; end

  private
  def method_missing(method, *args, &block)
    if method.to_s =~ /^(.*)_with_mbti$/
      [self.send($1, *args, &block), with_mbti].join(" ")
    else
      super
    end
  end

end
