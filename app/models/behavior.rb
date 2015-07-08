class Behavior
  LETTERS = Attitude::LETTERS.product(Realm::LETTERS).map(&:join)

  def initialize(letters)
    raise "#{letters} isn't a Behavior" unless LETTERS.include?(letters)
    @index = LETTERS.index(letters)
    @path = letters
  end
  attr_reader :path

  BEHAVIORS = LETTERS.collect{|letters| Behavior.new(letters)}
  def self.by_attitude; BEHAVIORS.values_at(0,1,4,5,2,3,6,7,8,9,12,13,10,11,14,15); end
  def self.by_realm; BEHAVIORS.values_at(0,4,1,5,8,12,9,13,2,6,3,7,10,14,11,15); end
  def self.find(letters); BEHAVIORS[LETTERS.index(letters)]; end

  def mbti; path.mbti_order.upcase; end

  def attitude; Attitude.find(path[0,2]); end
  def realm; Realm.find(path.last); end

  def description; [attitude.direction, adjective, attitude.power].join(" ") ; end
  def name; realm.send(attitude.path); end
  def alt; realm.send(attitude.path + "2"); end

  def sequence; attitude.sequence.add(realm); end

  def method_missing(method, *args, &block)
    if method.to_s =~ /^(.*)_with_mbti$/
      [self.send($1, *args, &block), mbti.parenthetical].join(" ")
    else
      realm.send(method, *args, &block)
    end
  end
end
