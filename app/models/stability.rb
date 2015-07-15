class Stability
  LETTERS = %w{j i}

  def initialize(letter)
    raise "#{letter} isn't a Stability" unless LETTERS.include?(letter)
    @index = LETTERS.index(letter)
    @path = letter
  end
  attr_reader :path

  STABILITIES = LETTERS.collect{|letters| Stability.new(letters)}
  def self.all; STABILITIES; end
  def self.find(letters); STABILITIES[LETTERS.index(letters)]; end

  def mbti; path.upcase; end

  def name
    case path
    when "j"
      "proactive"
    when "i"
      "reactive"
    end
  end

  def trumps
    case path
    when "j"
      "zeitgebers (J) trump quality (I)"
    when "i"
      "quality (I) trumps zeitgebers (J)"
    end
  end

  def method_missing(method, *args, &block)
    if method.to_s =~ /^(.*)_with_mbti$/
      [self.send($1, *args, &block), mbti.parenthetical].join(" ")
    else
      super
    end
  end
end
