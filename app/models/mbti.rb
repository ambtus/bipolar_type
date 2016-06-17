class Mbti < Phrase

  def initialize(string)
    attitude1 = Attitude.send(string.first)
    attitude2 = Attitude.send(string.last)
    realm1 = Realm.send(string.second)
    realm2 = Realm.send(string.third)
    @quad = [attitude1, realm1, realm2, attitude2]
    super @quad
  end
  attr_reader :quad

  def mbti; Noun.new quad.map(&:mbti).join; end
  def inspect; quad.map(&:inspect).join; end
  def path; quad.map(&:path).join; end
  def to_s; path.to_s; end
  def to_str; to_s; end

  def name; mbti; end

  def attitude; path.first + path.last; end
  def realms; @quad[1,2]; end

end
