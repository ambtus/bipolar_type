class Attitude
  LETTERS = %w{ ij ep ej ip}

  def initialize(letter)
    raise "#{letter} isn't an Attitude" unless LETTERS.include?(letter)
    @index = LETTERS.index(letter)
    @path = letter
  end
  attr_reader :index, :path
  def <=>(other); self.index <=> other.index; end
  def mbti; path.upcase; end
  def name; %w{ Bottom Top  Dom  Sub }[@index]; end
  def result; %w{ sensitive energetic strong overweight  }[@index]; end

  ATTITUDES = LETTERS.collect{|letter| Attitude.new(letter)}
  def self.all; ATTITUDES; end
  def self.find(letter); ATTITUDES[LETTERS.index(letter)]; end

  def +(realm); Subtype.find(self.path + realm.path); end
  def subtypes; Realm.all.add(self); end

  def method_missing(method, *args, &block)
    if method.to_s =~ /^(.*)_with_mbti$/
      [self.send($1, *args, &block), mbti.parenthetical].join(" ")
    else
      super
    end
  end

end
