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
  def pair; [realm, attitude]; end

  def quads; Quad.all.select{|q| q.subtypes.include?(self)}; end

  def method_missing(method, *args, &block)
    if method.to_s =~ /^(.*)_with_mbti$/
      [self.send($1, *args, &block).gsub('<br />', " & "), mbti.parenthetical].join(" ")
    else
      realm.send(method, *args, &block)
    end
  end

  def nature; realm.gsub(attitude.nature); end
  def subconscious; realm.gsub(attitude.subconscious); end
  def result; realm.send(attitude.result); end
  def conscious; realm.gsub(attitude.conscious); end
  def role; realm.gsub(attitude.role); end

  def advice; realm.send(attitude.advice); end

  def name; pair.map(&:name).join; end

  def ip_only
    return "" unless attitude.path == "ip"
    "or<br />I am #{anorexic}"
  end

  def description; ["I am too #{result}","I should #{conscious}!",ip_only].join('<br />').html_safe; end
end
