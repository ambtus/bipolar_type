class Subtype
  LETTERS = (Attitude::LETTERS.product(Realm::LETTERS)).map(&:join)

  def initialize(string)
    @index = LETTERS.index(string)
    raise "#{string} isn't a Subtype" unless @index
    @letters = string
    @attitude = Attitude.find(letters.first)
    @realm = Realm.find(letters.last)
  end
  attr_reader :letters, :attitude, :realm

  SUBTYPES = LETTERS.collect{|choice| Subtype.new(choice)}
  def self.all; SUBTYPES; end

  def self.find(letters); SUBTYPES[LETTERS.index(letters)]; end

  def wing?(subtypes)
    subtypes.each{|s| return true if s.attitude == self.attitude}
    subtypes.each{|s| return true if s.realm == self.realm}
    return false
  end

  def description; [realm.description, attitude.description].join(" "); end

  def mbti_downcase; [attitude.mbti, realm.mbti].join.mbti_order; end
  def mbti_upcase; mbti_downcase.upcase; end

  def basic; attitude.basic; end
  def mbti(basic=true); basic ? mbti_upcase : mbti_downcase; end

  def short(weak=false); attitude.short(realm, weak); end

end
