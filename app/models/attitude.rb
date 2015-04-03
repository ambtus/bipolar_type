class Attitude
  LETTERS = %w{a b c d}

  def initialize(string)
    @index = LETTERS.index(string)
    raise "#{string} isn't an Attitude" unless @index
    @letter = string
  end
  attr_reader :letter

  ATTITUDES = LETTERS.collect{|choice| Attitude.new(choice)}
  def self.all; ATTITUDES; end

  def self.find(letter); ATTITUDES[LETTERS.index(letter)]; end

  def subtypes; Subtype.all.select{|s| s.attitude == self}; end

  def mbti; %w{iP eP eJ iJ}[@index]; end
  def season; %w{spring summer autumn winter }[@index]; end
  def description; season.capitalize; end
  def basic; mbti.first; end

  def short(realm, weak=false); realm.send(season, weak); end

end
