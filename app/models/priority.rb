class Priority
  LETTERS = %w{i j k l}

  def initialize(string)
    @index = LETTERS.index(string)
    raise "#{string} isn't an Priority" unless @index
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
  def adjective; %w{current recent previous historical}[@index]; end
  def description; adjective.capitalize; end

  def strong?; @index < 2 ? true : false; end
  def differentiated?; [1,2].include?(@index) ? false : true; end

  def now_or_never; %w{currently often rarely never}[@index]; end
  def because_or_although; strong? ? "because" : "although"; end

  def +(behavior); Subtype.find(self.letter + behavior.letters); end
end
