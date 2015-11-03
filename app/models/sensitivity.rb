class Sensitivity

  LETTERS = %w{e i}

  def initialize(letter)
    raise "#{letter} isn't a Sensitivity" unless LETTERS.include?(letter)
    @index = LETTERS.index(letter)
    @path = letter
  end
  attr_reader :index, :path

  SENSITIVITIES = LETTERS.collect{|letter| Sensitivity.new(letter)}
  def self.all; SENSITIVITIES; end
  def self.find(letter); SENSITIVITIES[LETTERS.index(letter)]; end

  def +(tendency); Subtype.find(self.path + tendency.path); end
  def subtypes; Tendency.all.add(self); end

  def opposite_path; LETTERS.reverse[@index]; end
  def opposite; Sensitivity.find(opposite_path); end

  def sensitivity; %w{insensitive oversensitive}[@index]; end
end
