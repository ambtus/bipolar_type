class Subtype
  LETTERS = Realm::LETTERS.multiply(Attitude::LETTERS).flatten

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

  def nature; realm.gsub(attitude.nature); end
  def subconscious; realm.gsub(attitude.subconscious); end
  def result; realm.send(attitude.result); end
  def conscious; realm.gsub(attitude.conscious); end
  def role; realm.gsub(attitude.role); end

  def advice; realm.send(attitude.advice); end

  def name; pair.map(&:name).join; end

  def ip_only
    return nil unless attitude.path == "ip"
    "I am #{phobic}"
  end
  def ej_only
    return nil unless attitude.path == "ej"
    "I create my own #{resources}"
  end

  def only; [ip_only,ej_only].flatten.compact.first; end
  def i_am; "I am too #{result}"; end
  def i_should; "I should #{conscious}"; end

end
