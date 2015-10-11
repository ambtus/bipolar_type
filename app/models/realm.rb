class Realm
  LETTERS = %w{s n f t }

  def initialize(letter)
    raise "#{letter} isn't an Realm" unless LETTERS.include?(letter)
    @index = LETTERS.index(letter)
    @path = letter
  end
  attr_reader :index, :path

  REALMS = LETTERS.collect{|letter| Realm.new(letter)}
  def self.all; REALMS; end
  def self.find(letter); REALMS[LETTERS.index(letter)]; end

  def +(attitude); Subtype.find(self.path + attitude.path); end
  def subtypes; Attitude.all.add(self); end

  LETTERS.each {|r| define_singleton_method(r) {find(r)}}

  # touch realm.rb to reload realm.csv in development mode
  require 'csv'
  arr_of_arrs = CSV.read("config/initializers/realm.csv")
  first = arr_of_arrs.shift
  raise "realm.csv needs to be re-ordered" unless LETTERS == first[1,4]
  arr_of_arrs.each {|row| define_method(row.first.gsub(' ', '_')) {row[@index + 1] || [adjective.ly,row.first].join(" ")}}

  def name; sensory.capitalize; end
  def consume1; consume.split.first; end

  def introverted; "doesn’t #{consume} much or #{produce} much"; end
  def extroverted; "#{consume.s} a lot and #{produce.s} a lot"; end

  def gsub(string)
    string.gsub('extroverted', extroverted).
    gsub('introverted', introverted).
    gsub('consuming', consume1.ing).
    gsub('producing', produce.ing).
    gsub('consume', consume1).
    gsub('produce', produce)
  end

  def run; "keep #{produce.ing}"; end
  def binge; "keep #{consume1.ing}"; end
  def sit; "stop #{produce.ing}"; end
  def fast; "stop #{consume1.ing}"; end

end
