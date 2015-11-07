class Subtype

  LETTERS = Realm::LETTERS.multiply(Sensitivity::LETTERS).flatten

  def initialize(letters)
    @index = LETTERS.index(letters)
    @path = letters
  end
  attr_reader :path

  SUBTYPES = LETTERS.collect{|letters| Subtype.new(letters)}
  def self.all; SUBTYPES; end

  def self.index(letters)
    raise "#{letters} isn't a Subtype" unless LETTERS.include?(letters)
    LETTERS.index(letters)
  end
  def self.find(letters); SUBTYPES[index(letters)]; end

  def realm; Realm.find(path.first); end
  def sensitivity; Sensitivity.find(path.last); end

  def <=>(other); path.reverse <=> other.path.reverse; end

  def invert; realm + sensitivity.invert; end

  def function; path.capitalize.to_word; end

  def name; "#{realm.send(sensitivity.word).capitalize} (#{function})"; end

  def obfuscated; "#{realm.kind} #{sensitivity.obfuscated}"; end

  delegate :kind, to: :realm

end
