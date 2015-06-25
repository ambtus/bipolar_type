# Encoding: utf-8
class Nurture
  def self.my_path; "piej"; end
  def self.first; Nurture.find(my_path); end

  LETTERS = Attitude::LETTERS.permutation(4).map(&:join)

  def initialize(letters)
    raise "#{letters} isn't a Nurture" unless LETTERS.include?(letters)
    @index = LETTERS.index(letters)
    @path = letters
  end
  attr_reader :path

  NURTURES = LETTERS.collect{|letters| Nurture.new(letters)}
  def self.all; NURTURES; end
  def self.find(letters); NURTURES[LETTERS.index(letters)]; end

  def +(nature); Type.find(nature.path + self.path); end
  def types; Nature.all.add(self); end

  def attitudes; path.scan(/./).collect{|letter| Attitude.find(letter)}; end
  def subtypes; attitudes.add(Realm.all); end
  def ordered_subtypes; subtypes.sort_by{|s| s.attitude}; end

  def messages; ordered_subtypes.map(&:verb); end
  def stages; ordered_subtypes.map(&:stage); end
  def mbti; ordered_subtypes.map(&:mbti).join("–"); end
  def realms; ordered_subtypes.map(&:realm); end

  private
  def method_missing(method, *args, &block)
    if method.to_s =~ /^(.*)_with_mbti$/
      [self.send($1, *args, &block), mbti.parenthetical].join(" ")
    else
      super
    end
  end

end

