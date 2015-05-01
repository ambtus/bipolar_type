class Realm
  LETTERS = %w{t s n f}

  def initialize(string)
    raise "#{string} isn't an Realm" unless LETTERS.include?(string)
    @index = LETTERS.index(string)
    @letter = string
  end
  attr_reader :letter, :index

  REALMS = LETTERS.collect{|choice| Realm.new(choice)}
  def self.all; REALMS; end

  def self.find(letter); REALMS[LETTERS.index(letter)]; end

  def next; Realm.all[(@index + 1).modulo(4)]; end
  def previous; Realm.all[(@index + 3).modulo(4)]; end

  def mbti; letter.upcase; end

  def +(attitude); Behavior.find(self.letter + attitude.letter); end
  def behaviors; Attitude.all.collect{|attitude| self + attitude}; end

end
