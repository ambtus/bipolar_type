class Priority
  LETTERS = %w{i j k l}

  def initialize(string)
    raise "#{string} isn't a Priority" unless LETTERS.include?(string)
    @index = LETTERS.index(string)
    @letter = string
  end
  attr_reader :letter, :index

  PRIORITIES = LETTERS.collect{|choice| Priority.new(choice)}
  def self.all; PRIORITIES; end

  def self.find(letter); PRIORITIES[LETTERS.index(letter)]; end
  def self.ideal; all[2]; end

  def subtypes; Subtype.all.select{|s| s.priority == self}; end

  def next; Priority.all[(@index + 1).modulo(4)]; end
  def previous; Priority.all[(@index + 3).modulo(4)]; end

  def mbti; %w{dominant auxiliary tertiary inferior}[@index]; end

  def +(behavior); Subtype.find(self.letter + behavior.letters); end
end
