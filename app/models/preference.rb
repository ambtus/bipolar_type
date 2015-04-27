class Preference
  LETTERS = %w{i j k l}

  def initialize(string)
    @index = LETTERS.index(string)
    raise "#{string} isn't an Preference" unless @index
    @letter = string
  end
  attr_reader :letter, :index

  PREFERENCES = LETTERS.collect{|choice| Preference.new(choice)}
  def self.all; PREFERENCES; end

  def self.find(letter); PREFERENCES[LETTERS.index(letter)]; end

  def subtypes; Subtype.all.select{|s| s.preference == self}; end

  def next; Preference.all[(@index + 1).modulo(4)]; end
  def previous; Preference.all[(@index + 3).modulo(4)]; end

  def mbti; %w{dominant auxiliary tertiary inferior}[@index]; end
  def adjective; %w{primary secondary tertiary quaternary}[@index]; end
  def description; adjective.capitalize; end

end
