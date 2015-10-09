class Realm
  LETTERS = %w{sf nt nf st }

  def initialize(letter)
    raise "#{letter} isn't an Realm" unless LETTERS.include?(letter)
    @index = LETTERS.index(letter)
    @path = letter
  end
  attr_reader :index, :path
  def mbti; path.upcase; end

  REALMS = LETTERS.collect{|letter| Realm.new(letter)}
  def self.all; REALMS; end
  def self.find(letter); REALMS[LETTERS.index(letter)]; end

  def +(attitude); Subtype.find(self.path + attitude.path); end
  def subtypes; Attitude.all.add(self); end

  LETTERS.each {|r| define_singleton_method(r) {find(r)}}

  Attitude.all.each {|a| define_method(a.path) {[self,a].to_mbti}}


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

  def method_missing(method, *args, &block)
    if method.to_s =~ /^(.*)where$/
      index == 0 ? $1+"where" : $1+"thing"
    elsif method.to_s =~ /^(.*)_with_mbti$/
      [self.send($1, *args, &block).gsub('<br />', " & "), mbti.parenthetical].join(" ")
    else
      super
    end
  end

end
