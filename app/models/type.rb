class Type

  def initialize(string)
    @path = string
    @realms = string.scan(/./).collect{|x| Realm.find(x)}
  end

  attr_reader :path, :realms

  def subtypes
    Attitude::LETTERS.each_with_index.collect do |attitude_letter, index|
      Subtype.find(attitude_letter + @realms[index].letter)
    end
  end


  def mbtis; subtypes.map(&:mbti).join("-"); end
  def opposite; Type.new(@path.reverse); end

  def truetypes
    subtypes.collect do |dominant|
      (subtypes - [dominant]).collect do |auxiliary|
       Truetype.new(dominant.letters+auxiliary.letters)
      end
    end.flatten
  end
end
