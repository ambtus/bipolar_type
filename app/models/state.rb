class State
  #LETTERS = Attitude::LETTERS.product(Realm::LETTERS).map(&:join)
  LETTERS = ["et", "en", "jt", "jn", 
             "es", "ef", "js", "jf", 
             "pt", "pn", "it", "in",
             "ps", "pf", "is", "if"]

  def initialize(string)
    raise "#{string} isn't a State" unless LETTERS.include?(string)
    @index = LETTERS.index(string)
    @letters = string
    @attitude_letter = string[0]
    @realm_letter = string[1]
  end
  attr_reader :letters

  STATES = LETTERS.collect{|choice| State.new(choice)}
  def self.all; STATES; end
  def self.find(letters); STATES[LETTERS.index(letters)]; end

  def mbti; letters.mbti_order.upcase; end
  def with_mbti; "(#{mbti})"; end

  def attitude; Attitude.find(@attitude_letter); end
  def realm; Realm.find(@realm_letter); end

  def short; realm.send(attitude.adjective); end

  private
  def method_missing(method, *args, &block)
    if method.to_s =~ /^(.*)_with_mbti$/
      [self.send($1, *args, &block), with_mbti].join(" ")
    else
      realm.send(method, *args, &block)
    end
  end
end
