class Subtype
  LETTERS = Sensitivity::LETTERS.multiply(Tendency::LETTERS).flatten

  def initialize(letters)
    raise "#{letters} isn't a Subtype" unless LETTERS.include?(letters)
    @index = LETTERS.index(letters)
    @path = letters
  end
  attr_reader :path

  SUBTYPES = LETTERS.collect{|letters| Subtype.new(letters)}
  def self.all; SUBTYPES; end
  def self.find(letters); SUBTYPES[LETTERS.index(letters)]; end

  def +(subtype); Pair.find(subtype.path + self.path); end
  def pairs; potentials.add(self); end

  def potentials; realm.others.collect{|r| sensitivity.opposite + (r + attitude.opposite) }; end

  def sensitivity; Sensitivity.find(path.first); end
  def tendency; Tendency.find(path[1,2]); end

  delegate :realm, :attitude, :name, :nature, :location, :too, :goal, :never, to: :tendency

  def sa
    case path.chars.values_at(0,2).join
    when "ip", "ej"
      "rational"
    when "ij", "ep"
      "arational"
     end
  end


end
