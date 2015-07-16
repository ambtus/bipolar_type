# Encoding: utf-8
class Type
  def self.my_path; Realm::LETTERS.join + Attitude::LETTERS.join; end
  def self.first; Type.new(my_path); end

  def initialize(letters)
    @path = letters
    @realm_letters = letters[0,4].scan(/./)
    @attitude_letters = letters[4,4].scan(/./)
  end
  attr_reader :path

  def realms; @realm_letters.collect{|letter| Realm.find(letter)}; end
  def attitudes; @attitude_letters.collect{|letter| Attitude.find(letter)}; end
  def behaviors
    [
      attitudes.first + realms.first,
      attitudes.second + realms.first,
      attitudes.first + realms.second,
      attitudes.second + realms.third,
      attitudes.third + realms.second,
      attitudes.fourth + realms.third,
      attitudes.third + realms.fourth,
      attitudes.fourth + realms.fourth
    ]
  end

  def mbti; behaviors.map(&:mbti).join; end

  def mbtis
    [
     behaviors.values_at(1,2),
     behaviors.values_at(0,3),
     behaviors.values_at(0,4),
     behaviors.values_at(1,5),
     behaviors.values_at(6,2),
     behaviors.values_at(7,3),
     behaviors.values_at(7,4),
     behaviors.values_at(6,5),
    ].map(&:to_mbti)
  end

end

