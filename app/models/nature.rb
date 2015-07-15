# Encoding: utf-8
class Nature
  def self.my_path; Realm::LETTERS.join; end
  def self.first; Nature.find(my_path); end

  LETTERS = Realm::LETTERS.permutation(4).map(&:join)

  def initialize(letters)
    raise "#{letters} isn't a Nature" unless LETTERS.include?(letters)
    @index = LETTERS.index(letters)
    @path = letters
  end
  attr_reader :path

  NATURES = LETTERS.collect{|letters| Nature.new(letters)}
  def self.all; NATURES; end
  def self.find(letters); NATURES[LETTERS.index(letters)]; end

  def letters; path.scan(/./); end

  def realms; letters.collect{|letter| Realm.find(letter)}; end
  def subtypes; realms.add(Attitude.all); end
  def names; subtypes.map(&:name); end
  def behaviors; subtypes.map(&:behaviors).flatten;end
  def types; Type.all.select{|n| n.nature == self}; end

  def mbti; subtypes.map(&:mbti).join("–"); end
  def name; mbti; end
  def method_missing(method, *args, &block)
    if method.to_s =~ /^(.*)_with_mbti$/
      [self.send($1, *args, &block), mbti.parenthetical].join(" ")
    else
      super
    end
  end

end

