class Quality
  LETTERS = %w{e i}

  def initialize(letter)
    raise "#{letter} isn't a Quality" unless LETTERS.include?(letter)
    @index = LETTERS.index(letter)
    @path = letter
  end
  attr_reader :path

  QUALITIES = LETTERS.collect{|letters| Quality.new(letters)}
  def self.all; QUALITIES; end
  def self.find(letters); QUALITIES[LETTERS.index(letters)]; end

  def mbti; path.upcase; end

  def sensitive?; @index.odd?; end
  def adjective; sensitive? ? "sensitive to" : "insensitive to"; end
  def name; [adjective, "quality"].join(" "); end

  def description
    case path
    when "e"
      "consumes more or less depending on emptiness"
    when "i"
      "consumes more or less depending on quality"
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
