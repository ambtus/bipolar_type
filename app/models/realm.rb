class Realm

  # touch realm.rb to reload realm.csv in development mode
  require 'csv'
  arr_of_arrs = CSV.read("config/initializers/realm.csv")
  LETTERS = arr_of_arrs.shift
  arr_of_arrs.each {|row| define_method(row.first.gsub(' ', '_')) {row[@index] || [generic.ly,row.first].join(" ")}}

  def initialize(letter)
    raise "#{letter} isn't an Realm" unless LETTERS.include?(letter)
    @index = LETTERS.index(letter)
    @path = letter
  end
  attr_reader :index, :path

  REALMS = LETTERS.collect{|letter| Realm.new(letter)}
  def self.all; REALMS[1,4]; end
  def self.generic; REALMS.first; end
  def self.find(letter); REALMS[LETTERS.index(letter)]; end

  def +(attitude); Subtype.find(self.path + attitude.path); end
  def subtypes; Attitude.all.add(self); end

  LETTERS.each {|r| define_singleton_method(r) {find(r)}}

  Attitude::LETTERS.each_with_index { |path, index| define_method(path) {subtypes[index]}}

  def name; sensory.capitalize; end

  def high_on_energy; "#{generically} full"; end

end
