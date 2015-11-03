class Realm

  # touch realm.rb to reload realm.csv in development mode
  require 'csv'
  arr_of_arrs = CSV.read("config/initializers/realm.csv")
  LETTERS = arr_of_arrs.shift.drop(1)
  arr_of_arrs.each {|row| define_method(row.first.gsub(' ', '_')) {row[@index] || row.first}}

  def initialize(letter)
    raise "#{letter} isn't an Realm" unless LETTERS.include?(letter)
    @index = LETTERS.index(letter) + 1
    @path = letter
  end
  attr_reader :index, :path

  REALMS = LETTERS.collect{|letter| Realm.new(letter)}
  def self.all; REALMS; end
  def self.find(letter); REALMS[LETTERS.index(letter)]; end

  def +(attitude); Tendency.find(self.path + attitude.path); end
  def tendencies; Attitude.all.add(self); end

  def consume1; consume.split.first; end

  def activity; [produce, results].join(" "); end

  def gain; [consume, external].join(" "); end
  def lose; [use, internal].join(" "); end

  def others; Realm.all - [self]; end

end
