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
  LETTERS.each {|l| define_singleton_method(l) {find(l)}}

  def +(realm); Subtype.find(realm.path + self.path); end

  def invert_path; LETTERS.reverse[@index]; end
  def invert; Sensitivity.find(invert_path); end

  def location; %w{externals internals}[@index]; end
  def state; %w{full empty}[@index]; end

  def direction; %w{compulsion aversion}[@index]; end

  def i?; path == "i"; end

end
