class Attitude
  LETTERS = %w{e f g h}

  def initialize(string)
    @index = LETTERS.index(string)
    raise "#{string} isn't an Attitude" unless @index
    @letter = string
  end
  attr_reader :letter, :index

  ATTITUDES = LETTERS.collect{|choice| Attitude.new(choice)}
  def self.all; ATTITUDES; end

  def self.find(letter); ATTITUDES[LETTERS.index(letter)]; end

  def subtypes; Subtype.all.select{|s| s.attitude == self}; end

  def next; Attitude.all[(@index + 1).modulo(4)]; end
  def previous; Attitude.all[(@index + 3).modulo(4)]; end

  def mbti; %w{EP IP EJ IJ}[@index]; end
  def adjective; @index.even? ? "Extroverted" : "Introverted"; end
  def noun; @index < 2 ? "Extrovert" : "Introvert"; end
  def description; [adjective, noun].join; end
  def description_with_mbti; "#{description} (#{mbti})"; end

  # used in Subtype.check_numbers
  # must match the phrases in realm.rb
  def get_how_many; [1, 2, 2, 3][@index]; end
  def get_what; %w{large large medium small}[@index]; end
  def use_how_many; [3, 2, 2, 1][@index]; end
  def use_what; %w{small medium large large}[@index]; end

  def get?; @index < 2 ? true : false; end

end
