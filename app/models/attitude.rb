class Attitude

  LETTERS = %w{p j}

  def initialize(letter)
    raise "#{letter} isn't an Attitude" unless LETTERS.include?(letter)
    @index = LETTERS.index(letter)
    @path = letter
  end
  attr_reader :index, :path

  ATTITUDES = LETTERS.collect{|letter| Attitude.new(letter)}
  def self.all; ATTITUDES; end
  def self.find(letter); ATTITUDES[LETTERS.index(letter)]; end

  def +(realm); Tendency.find(realm.path + self.path); end
  def tendencies; Realm.all.add(self); end

  def opposite_path; LETTERS.reverse[@index]; end
  def opposite; Attitude.find(opposite_path); end

  def tendency; %w{full empty}[@index]; end
  def too; %w{high low}[@index]; end

  def goal; opposite.too; end
  def never; opposite.tendency; end

  def act; %w{gain lose}[@index]; end
  def react; %w{lose gain}[@index]; end

end
