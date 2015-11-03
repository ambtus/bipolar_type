class Attitude

  LETTERS = %w{e i}

  def initialize(letter)
    raise "#{letter} isn't an Attitude" unless LETTERS.include?(letter)
    @index = LETTERS.index(letter)
    @path = letter
  end
  attr_reader :index, :path

  ATTITUDES = LETTERS.collect{|letter| Attitude.new(letter)}
  def self.all; ATTITUDES; end
  def self.find(letter); ATTITUDES[LETTERS.index(letter)]; end

  def +(realm); Subtype.find(self.path + realm.path); end
  def subtypes; Realm.all.add(self); end

  def opposite_path; Attitude::LETTERS.reverse[@index]; end
  def opposite; Attitude.find(opposite_path); end

  def tendency; %w{empty full}[@index]; end
  def goal; %w{high low}[@index]; end
  def short; %w{gain1 act}[@index]; end
  def short2; %w{act gain1}[@index]; end
  def behave; %w{input output}[@index]; end
  def behave2; %w{output input}[@index]; end

  def behavior; %w{input output}[@index]; end
  def behavior2; %w{output input}[@index]; end
  def normalize; ["gain", "get rid of"][@index]; end
  def recover; ["get rid of", "gain"][@index]; end

end
