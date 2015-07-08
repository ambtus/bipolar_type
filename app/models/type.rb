class Type
  def self.my_path; Realm::LETTERS.join ; end
  def self.first; Type.new(my_path); end

  def initialize(letters)
    @path = letters
  end
  attr_reader :path

  def letters; path.scan(/./); end
  def realms; letters.collect{|l| Realm.find(l)}; end
  def behaviors; realms.add(Attitude.all); end

  def mbti; behaviors.map(&:mbti).join("–"); end

end
