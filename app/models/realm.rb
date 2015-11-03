class Realm

  # touch realm.rb to reload realm.csv in development mode
  require 'csv'
  arr_of_arrs = CSV.read("config/initializers/realm.csv")
  LETTERS = arr_of_arrs.shift
  arr_of_arrs.each {|row| define_method(row.first.gsub(' ', '_')) {row[@index] || row.first}}

  def initialize(letter)
    raise "#{letter} isn't an Realm" unless LETTERS.include?(letter)
    @index = LETTERS.index(letter)
    @path = letter
  end
  attr_reader :index, :path

  def <=>(other_realm); path <=> other_realm.path; end

  REALMS = LETTERS.collect{|letter| Realm.new(letter)}
  def self.all; REALMS[1,4]; end
  def self.find(letter); REALMS[LETTERS.index(letter)]; end

  def +(attitude); Subtype.find(attitude.path + self.path); end
  def subtypes; Attitude.all.add(self); end

  def name; location.capitalize; end
  def gain1; gain.split.first; end

  def input; [gain, resources].join(" "); end
  def output; [change, objects].join(" "); end

  def others; Realm.all - [self]; end

end
