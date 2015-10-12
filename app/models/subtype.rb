class Subtype
  LETTERS = Realm::LETTERS[1,4].multiply(Attitude::LETTERS.values_at(0,2,3,1)).flatten

  def initialize(letters)
    raise "#{letters} isn't a Subtype" unless LETTERS.include?(letters)
    @index = LETTERS.index(letters)
    @path = letters
  end
  attr_reader :path

  SUBTYPES = LETTERS.collect{|letters| Subtype.new(letters)}
  def self.all; SUBTYPES; end
  def self.find(letters); SUBTYPES[LETTERS.index(letters)]; end

  def realm; Realm.find(path[0,1]); end
  def attitude; Attitude.find(path[1,2]); end
  def pair; [realm, attitude]; end

  def quads; Quad.all.select{|q| q.subtypes.include?(self)}; end

  def opposite; Subtype.find(realm.path + attitude.opposite_path); end

  def method_missing(method, *args, &block); realm.send(method, *args, &block); end

  def name; pair.reverse.map(&:name).join; end
  def result; realm.send(attitude.result); end
  def i_am; "I am too #{result}"; end
  def should; realm.gsub(attitude.should); end
  def i_should; "I should #{should}"; end
  def short_role; realm.gsub(attitude.short_role); end
  def role; realm.gsub(attitude.role); end
  def advice; realm.gsub(attitude.advice); end

end
