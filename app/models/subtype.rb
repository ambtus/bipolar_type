class Subtype
  LETTERS = Attitude::LETTERS.product(Realm::LETTERS).map(&:join)

  def initialize(letters)
    raise "#{letters} isn't a Subtype" unless LETTERS.include?(letters)
    @index = LETTERS.index(letters)
    @path = letters
  end
  attr_reader :path

  SUBTYPES = LETTERS.collect{|letters| Subtype.new(letters)}
  def self.all; SUBTYPES; end
  def self.by_attitude; SUBTYPES.values_at(0,1,4,5,2,3,6,7,8,9,12,13,10,11,14,15); end
  def self.by_realm; SUBTYPES.values_at(0,4,1,5,8,12,9,13,2,6,3,7,10,14,11,15); end
  def self.find(letters); SUBTYPES[LETTERS.index(letters)]; end

  def mbti; path.mbti_order.upcase; end

  def attitude; Attitude.find(path[0,2]); end
  def realm; Realm.find(path.last); end

  def description; (attitude.description); end
  def name; [realm.adjective, attitude.name].join(" "); end
  def adverb; attitude.quality.sensitive? ? sensory.ly : adjective.ly; end
  def short; [adverb, attitude.short].join(" "); end
  def description; [realm.replace(attitude.descriptive_name), short.parenthetical].join(" "); end
  def trumps; realm.replace(attitude.trumps); end

  def natures; Nature.all.select{|n| n.subtypes.include?(self)}; end
  def behaviors; attitude.quas.collect{|a| Behavior.find(a.path + realm.path)}; end

  def method_missing(method, *args, &block)
    if method.to_s =~ /^(.*)_with_mbti$/
      [self.send($1, *args, &block), mbti.parenthetical].join(" ")
    else
      realm.send(method, *args, &block)
    end
  end
end
