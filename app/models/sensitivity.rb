class Sensitivity

  LETTERS = %w{e i}

  def initialize(letter)
    @index = LETTERS.index(letter)
    @path = letter
  end
  attr_reader :index, :path

  SENSITIVITIES = LETTERS.collect{|letter| Sensitivity.new(letter)}
  def self.all; SENSITIVITIES; end

  def self.index(letter)
    raise "#{letter} isn't a Sensitivity" unless LETTERS.include?(letter)
    LETTERS.index(letter)
  end
  def self.find(letter); SENSITIVITIES[index(letter)]; end

  def +(realm); Subtype.find(realm.path + self.path); end

  def opposite_path; LETTERS.reverse[@index]; end
  def opposite; Sensitivity.find(opposite_path); end

  def word; %w{external internal}[@index]; end

  def obfuscated; %w{compulsion aversion}[@index]; end

end
