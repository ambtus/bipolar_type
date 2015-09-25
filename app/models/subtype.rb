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

  def realm; Realm.find(path[0,2]); end
  def attitude; Attitude.find(path[2,2]); end

  def quads; Quad.all.select{|q| q.subtypes.include?(self)}; end

  def name; realm.send(attitude.fat); end

  def short; [attitude.insensitive, realm.physical, attitude.consumer].join(" "); end
  def long
    case attitude.path
    when "ep"
      "lots of useless #{realm.fat_deposits}"
    when "ej"
      "lots of #{realm.muscles}"
    when "ip"
      "not enough #{realm.muscles}"
    when "ij"
      "only essential #{realm.fat_deposits}"
    end
  end

  def description; [short, long].join('<br />').html_safe; end
  def self.ordered
    all.values_at(0,1,4,5,2,3,6,7,8,9,12,13,10,11,14,15)
  end

  def method_missing(method, *args, &block)
    if method.to_s =~ /^(.*)_with_mbti$/
      [self.send($1, *args, &block), mbti.parenthetical].join(" ")
    else
      realm.send(method, *args, &block)
    end
  end

end
