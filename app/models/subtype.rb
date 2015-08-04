class Subtype
  LETTERS = Realm::LETTERS.multiply(Attitude::LETTERS).flatten

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

  def realm; Realm.find(path[0,1]); end
  def attitude; Attitude.find(path[1,2]); end

  def self.by_realm; SUBTYPES.values_at(0,1,4,5,2,3,6,7,8,9,12,13,10,11,14,15); end
  def self.by_attitude; SUBTYPES.values_at(0,4,1,5,8,12,9,13,2,6,3,7,10,14,11,15); end

  def quads; Quad.all.select{|q| q.subtypes.include?(self)}; end

  def name; [realm, attitude].map(&:name).join; end

  def method_missing(method, *args, &block)
    if method.to_s =~ /^(.*)_with_mbti$/
      [self.send($1, *args, &block), mbti.parenthetical].join(" ")
    else
      realm.send(method, *args, &block)
    end
  end

end
