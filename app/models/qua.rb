class Qua
  LETTERS = %w{e j p i}

  def initialize(letters)
    raise "#{letters} isn't a Qua" unless LETTERS.include?(letters)
    @index = LETTERS.index(letters)
    @path = letters
  end
  attr_reader :path

  QUAS = LETTERS.collect{|letters| Qua.new(letters)}
  def self.all; QUAS; end
  def self.find(letters); QUAS[LETTERS.index(letters)]; end

  def mbti; path.mbti_order.upcase; end

  def qua; Quality::LETTERS.include?(path) ? Quality.find(path) : Quantity.find(path.first); end

  def method_missing(method, *args, &block)
    if method.to_s =~ /^(.*)_with_mbti$/
      [self.send($1, *args, &block), mbti.parenthetical].join(" ")
    else
      qua.send(method, *args, &block)
    end
  end
end
