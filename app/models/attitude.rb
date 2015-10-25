class Attitude

  # touch attitude.rb to reload attitude.csv in development mode
  require 'csv'
  arr_of_arrs = CSV.read("config/initializers/attitude.csv")
  LETTERS = arr_of_arrs.shift
  arr_of_arrs.each {|row| define_method(row.first.gsub(' ', '_')) {row[@index] || row.first}}

  def initialize(letter)
    raise "#{letter} isn't an Attitude" unless LETTERS.include?(letter)
    @index = LETTERS.index(letter)
    @path = letter
  end
  attr_reader :index, :path

  ATTITUDES = LETTERS.collect{|letter| Attitude.new(letter)}
  def self.all; ATTITUDES[1,4]; end
  def self.find(letter); ATTITUDES[LETTERS.index(letter)]; end

  def +(realm); Subtype.find(realm.path + self.path); end
  def subtypes; Realm.all.add(self); end

  LETTERS.each {|r| define_singleton_method(r) {find(r)}}

  def short; [sensitivity, preference].join(" "); end
  def result; "#{how_much} stored energy"; end

  def name; short.titleize.squash; end

  def advice; [alternative, reaction.ing].join(" "); end

end
