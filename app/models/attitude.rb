class Attitude
  LETTERS = %w{e f g h}

  def initialize(string)
    raise "#{string} isn't an Attitude" unless LETTERS.include?(string)
    @index = LETTERS.index(string)
    @letter = string
  end
  attr_reader :letter, :index

  ATTITUDES = LETTERS.collect{|choice| Attitude.new(choice)}
  def self.all; ATTITUDES; end

  def self.find(letter); ATTITUDES[LETTERS.index(letter)]; end

  def next; Attitude.all[(@index + 1).modulo(4)]; end
  def previous; Attitude.all[(@index + 3).modulo(4)]; end

  def mbti; %w{EP IJ EJ IP}[@index]; end
  def stop_consuming?; @index.even? ? true : false; end
  def waste?; @index < 2 ? true : false; end

  def +(realm); Behavior.find(self.letter + realm.letter); end
  def behaviors; Realm.all.collect{|r| self + r}; end
  def subtypes; Subtype.all.select{|s| s.attitude == self}; end

end
