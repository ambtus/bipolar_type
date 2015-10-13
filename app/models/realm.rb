class Realm
  LETTERS = %w{x f t s n}

  def initialize(letter)
    raise "#{letter} isn't an Realm" unless LETTERS.include?(letter)
    @index = LETTERS.index(letter)
    @path = letter
  end
  attr_reader :index, :path

  REALMS = LETTERS.collect{|letter| Realm.new(letter)}
  def self.all; REALMS[1,4]; end
  def self.first; REALMS.first; end
  def self.find(letter); REALMS[LETTERS.index(letter)]; end

  def +(attitude); Subtype.find(self.path + attitude.path); end
  def subtypes; Attitude.all.add(self); end

  LETTERS.each {|r| define_singleton_method(r) {find(r)}}

  # touch realm.rb to reload realm.csv in development mode
  require 'csv'
  arr_of_arrs = CSV.read("config/initializers/realm.csv")
  first = arr_of_arrs.shift
  raise "realm.csv needs to be re-ordered" unless LETTERS == first
  arr_of_arrs.each {|row| define_method(row.first.gsub(' ', '_')) {row[@index] || [generic.ly,row.first].join(" ")}}

  def name; sensory.capitalize; end

  def gsub(attitude_string)
    attitude_string.
    gsub('filling up', fill_up.ing).
    gsub('going', go.ing).
    gsub('fill up', fill_up).
    gsub('go', go).
    gsub('full', full).
    gsub('empty', empty)
  end

end
