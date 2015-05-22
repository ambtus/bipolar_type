class Realm
  LETTERS = %w{t n s f}

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

  def adjective; %w{ financial mental physical emotional}[@index]; end
  def adverb; adjective + "ly"; end
  def input; %w{work look\ or\ learn eat\ or\ drink listen\ or\ sympathize}[@index]; end
  def gain; %w{ beg,\ borrow,\ or\ steal believe\ or\ trust feast\ or\ binge empathize\ or\ care}[@index]; end
  def output; %w{ buy choose walk talk}[@index]; end
  def lose; %w{ splurge\ or\ gift decide\ or\ solve\ problems run\ or\ jump cry\ or\ whine}[@index]; end
  def energy; %w{ money information calories emotions}[@index]; end
  def overfull; %w{rich smart fat emotional}[@index]; end
  def underfull; %w{poor stupid thin unemotional}[@index]; end
  def short; adjective; end

  def extroverted; "#{lose.s} but #{gain.s} after"; end
  def manic; "#{lose.s} but can’t #{gain}"; end
  def depressed; "#{gain.s} but can’t #{lose}"; end
  def introverted; "#{gain.s} but #{lose.s} after"; end

  private
  def method_missing(method, *args, &block)
    if method.to_s =~ /^(.*)_with_mbti$/
      [self.send($1, *args, &block), with_mbti].join(" ")
    else
      super
    end
  end

end
