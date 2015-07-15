class Attitude
  LETTERS = Quality::LETTERS.product(Quantity::LETTERS).map(&:join)

  def initialize(letters)
    raise "#{letters} isn't an Attitude" unless LETTERS.include?(letters)
    @index = LETTERS.index(letters)
    @path = letters
  end
  attr_reader :path

  ATTITUDES = LETTERS.collect{|letters| Attitude.new(letters)}
  def self.all; ATTITUDES; end
  def self.find(letters); ATTITUDES[LETTERS.index(letters)]; end

  def mbti; path.upcase; end

  def quality; Quality.find(path.first); end
  def quantity; Quantity.find(path.last); end
  def quas; [quality, quantity]; end

  def +(attitude); Subtype.find(self.path + attitude.path); end
  def subtypes; Realm.all.add(self); end

  def short
    case path
      when "ej"
        "dominant"
      when "ij"
        "receptive"
      when "ip"
        "submissive"
      when "ep"
        "uncontrollable"
    end
  end

  def descriptive_name; [quality.name, quantity.name].join(" & "); end
  def description; [descriptive_name, short.parenthetical].join(" "); end
  def name
    case path
      when "ej"
        "Dom"
      when "ij"
         "Bottom"
      when "ip"
        "Sub"
      when "ep"
        "Top"
    end
  end

  def trumps
    case path
      when "ej"
        "zeitgebers trump internal signals of emptiness which trump external signals of quality"
      when "ij"
        "both external signals of quality and zeitgebers trump internal signals of emptiness"
      when "ip"
        "external signals of quality trump internal signals of emptiness which trump zeitgebers"
      when "ep"
        "internal signals of emptiness trump both external signals of quality and zeitgebers"
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
