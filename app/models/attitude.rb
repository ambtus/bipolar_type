class Attitude
  LETTERS = %w{e j p i}
  def opposite_letter; %w{i p j e}[@index]; end

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

  def opposite; Attitude.find(opposite_letter); end

  def problem_letters; LETTERS - [letter, opposite_letter]; end

  def attitude_problems; problem_letters.collect{|pl| AttitudeProblem.find(letter + pl)}; end

  def mbti; letter.upcase; end

  def +(realm); Behavior.find(realm.letter + self.letter); end
  def behaviors; Realm.all.collect{|realm| self + realm}; end
end
