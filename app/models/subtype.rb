class Subtype
  LETTERS = Behavior.all.collect{|b| b.wings.map(&:path).add(b.path)}.flatten.map(&:mbti_order).uniq

  def initialize(letters)
    raise "#{letters} isn't a Subtype" unless LETTERS.include?(letters)
    @index = LETTERS.index(letters)
    @path = letters
  end
  attr_reader :path

  SUBTYPES = LETTERS.collect{|letters| Subtype.new(letters)}
  def self.all; SUBTYPES; end
  def self.find(letters); SUBTYPES[LETTERS.index(letters)]; end

  def mbti; @path.upcase; end
  def method_missing(method, *args, &block)
    if method.to_s =~ /^(.*)_with_mbti$/
      [self.send($1, *args, &block), mbti.parenthetical].join(" ")
    else
      super
    end
  end

  def realm_letters; path.scan(/./).select{|l| Realm::LETTERS.include?(l)}; end
  def attitude_letters; path.scan(/./).select{|l| Attitude::LETTERS.include?(l)}; end
  def realms; realm_letters.collect{|l| Realm.find(l)}; end
  def attitudes; attitude_letters.collect{|l| Attitude.find(l)}; end
  def behaviors; realms.multiply(attitudes).flatten; end

  def attitude?; realms.size > attitudes.size; end

  def realm_adjectives; realms.map(&:adjective).join(" & "); end
  def attitude_sensitivities; attitudes.map(&:sensitivity).join(" & "); end

  def name; "sensitive to #{realm_adjectives} #{attitude_sensitivities}"; end

end
