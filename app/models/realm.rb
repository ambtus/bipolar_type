class Realm

  # touch realm.rb to reload realm.csv in development mode
  require 'csv'
  arr_of_arrs = CSV.read("config/initializers/realm.csv")
  LETTERS = arr_of_arrs.shift.drop(1)
  arr_of_arrs.each {|row| define_method(row.first) {row[@index].to_word_or_phrase}}

  def initialize(letter)
    @index = LETTERS.index(letter) + 1
    @path = letter
  end
  attr_reader :path

  REALMS = LETTERS.collect{|letter| Realm.new(letter)}
  def self.all; REALMS; end

  def self.index(letter)
    raise "#{letter} isn't a Realm" unless LETTERS.include?(letter)
    LETTERS.index(letter)
  end
  def self.find(letter); REALMS[index(letter)]; end

  def others; Realm.all - [self]; end

  def +(sensitivity); Subtype.find(self.path + sensitivity.path); end

  def i; self + Sensitivity.find("i"); end
  def e; self + Sensitivity.find("e"); end

  def name; kind.capitalize; end

  def gain; gain_phrase.to_phrase.words.first; end
  def consume; Phrase.new([*gain_phrase, resources]); end

end
