# Encoding: utf-8
class Nature
  def self.my_path; "ntsf"; end
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

  def +(nurture); Type.find(self.path + nurture.path); end
  def types; Nurture.all.add(self); end

  def realms; path.scan(/./).collect{|letter| Realm.find(letter)}; end

  def mbti; @path.upcase; end

  def sensitivities; %w{hypersensitive sensitive undersensitive insensitive}.add(" ").add(realms.map(&:neuro)); end

  private
  def method_missing(method, *args, &block)
    if method.to_s =~ /^(.*)_with_mbti$/
      [self.send($1, *args, &block), mbti.parenthetical].join(" ")
    else
      super
    end
  end

end

