class Quantity
  LETTERS = %w{p j}

  def initialize(letter)
    raise "#{letter} isn't a Quantity" unless LETTERS.include?(letter)
    @index = LETTERS.index(letter)
    @path = letter
  end
  attr_reader :path

  QUANTITIES = LETTERS.collect{|letters| Quantity.new(letters)}
  def self.all; QUANTITIES; end
  def self.find(letters); QUANTITIES[LETTERS.index(letters)]; end

  def mbti; path.upcase; end

  def sensitive?; @index.even?; end
  def adjective; sensitive? ? "sensitive to" : "insensitive to"; end
  def name; [adjective, "quantity"].join(" "); end

  def description
    case path
    when "p"
      "produces more or less depending on quantity"
    when "j"
      "produces more or less depending on zeitgebers"
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
