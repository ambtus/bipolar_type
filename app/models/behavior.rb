class Behavior
  LETTERS = Qua::LETTERS.product(Realm::LETTERS).map(&:join)

  def initialize(letters)
    raise "#{letters} isn't a Behavior" unless LETTERS.include?(letters)
    @index = LETTERS.index(letters)
    @path = letters
  end
  attr_reader :path

  BEHAVIORS = LETTERS.collect{|letters| Behavior.new(letters)}
  def self.all; BEHAVIORS; end
  def self.by_attitude; BEHAVIORS.values_at(0,1,4,5,2,3,6,7,8,9,12,13,10,11,14,15); end
  def self.by_realm; BEHAVIORS.values_at(0,4,1,5,8,12,9,13,2,6,3,7,10,14,11,15); end
  def self.find(letters); BEHAVIORS[LETTERS.index(letters)]; end

  def mbti; path.mbti_order.upcase; end

  def realm; Realm.find(path.last); end
  def qua; Qua.find(path.first); end
  def description; realm.replace(qua.description); end
  def name; realm.replace(qua.name); end

  def method_missing(method, *args, &block)
    if method.to_s =~ /^(.*)_with_mbti$/
      [self.send($1, *args, &block), mbti.parenthetical].join(" ")
    else
      super
    end
  end
end
