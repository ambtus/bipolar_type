class Personality
  LETTERS = Realm::LETTERS.permutation(4).map(&:join)

  def initialize(string)
    @letters = string
    @realm_letters = @letters.scan(/./)
  end
  attr_reader :letters, :realms

  PERSONALITIES = LETTERS.collect{|choice| Personality.new(choice)}
  def self.all; PERSONALITIES; end

  def self.find(letters); PERSONALITIES[LETTERS.index(letters)]; end

  def realms; @realm_letters.collect{|x| Realm.find(x)}; end
  def behaviors; realms.add(Attitude.all); end

  def mbtis; behaviors.map(&:mbti).join("-"); end

  def type_letters; behaviors.permutation(4).collect{|p| p.map(&:letters)}.map(&:join);end
  def types; type_letters.collect{|l| Type.new(l)}; end

end
