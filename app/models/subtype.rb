class Subtype
  LETTERS = Attitude::LETTERS.multiply(Realm::LETTERS).flatten

  def initialize(letters)
    raise "#{letters} isn't a Subtype" unless LETTERS.include?(letters)
    @index = LETTERS.index(letters)
    @path = letters
  end
  attr_reader :path
  def mbti; path.upcase.mbti_order; end

  SUBTYPES = LETTERS.collect{|letters| Subtype.new(letters)}
  def self.all; SUBTYPES; end
  def self.find(letters); SUBTYPES[LETTERS.index(letters)]; end

  def realm; Realm.find(path[2,1]); end
  def attitude; Attitude.find(path[0,2]); end

  def quads; Quad.all.select{|q| q.subtypes.include?(self)}; end

  def name; [realm, attitude].map(&:name).join; end
  def result; realm.send(attitude.result); end
  def manic_result; realm.send(attitude.manic_result); end
  def depressed_result; realm.send(attitude.depressed_result); end
  def next_mbti; [attitude.next, realm].to_mbti; end
  def previous_mbti; [attitude.previous, realm].to_mbti; end

  def method_missing(method, *args, &block)
    if method.to_s =~ /^(.*)_with_mbti$/
      [self.send($1, *args, &block), mbti.parenthetical].join(" ")
    else
      realm.send(method, *args, &block)
    end
  end

end
