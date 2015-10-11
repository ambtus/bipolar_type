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
  raise "realm.csv needs to be re-ordered" unless LETTERS == first
  arr_of_arrs.each {|row| define_method(row.first.gsub(' ', '_')) {row[@index] || [physical.ly,row.first].join(" ")}}

  def name; physical.capitalize; end
  def description; chemosensory; end
  def eat1; eat.split.first; end

  def introverted; "doesn’t #{eat} much or #{move} much"; end
  def extroverted; "#{eat.s} a lot and #{move.s} a lot"; end

  def gsub(string)
    string.gsub('extroverted', extroverted).
    gsub('introverted', introverted).
    gsub('consuming', eat1.ing).
    gsub('producing', move.ing).
    gsub('consume', eat1).
    gsub('produce', move)
  end

  def run; "keep #{move.ing}"; end
  def binge; "keep #{eat1.ing}"; end
  def sit; "stop #{move.ing}"; end
  def fast; "stop #{eat1.ing}"; end

end
