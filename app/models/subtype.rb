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
  def self.find(letters); SUBTYPES[LETTERS.index(letters)]; end

  def mbti; path.mbti_order.upcase; end
  def with_mbti; "(#{mbti})"; end

  def attitude; Attitude.find(path.first); end
  def realm; Realm.find(path.last); end

  def output?; attitude.output?; end
  def fast?; attitude.fast?; end
  def verb; [(output? ? "" : input), realm.send(attitude.attitude)].join(' ').squish; end
  def alt; realm.send("alt_#{attitude.attitude}"); end
  def alt_verb; [(output? ? "" : alt_input), alt].join(' ').squish; end

  def energy_or_strength; attitude.fast? ? "energy" : "strength"; end
  def description; [attitude.speed, attitude.direction, "of", realm.adjective, energy_or_strength].join(" ");end
  def name; verb; end

  def stage; [realm.adjective, attitude.stage].join(' '); end
  def state; [realm.adverb, attitude.state].join(' '); end
  def sequence; attitude.sequence.add(realm); end

  private
  def method_missing(method, *args, &block)
    if method.to_s =~ /^(.*)_with_mbti$/
      [self.send($1, *args, &block), with_mbti].join(" ")
    else
      realm.send(method, *args, &block)
    end
  end
end
