class Realm
  LETTERS = %w{s n f t }

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

  # touch realm.rb to reload realm.csv in development mode
  require 'csv'
  arr_of_arrs = CSV.read("config/initializers/realm.csv")
  first = arr_of_arrs.shift
  raise "realm.csv needs to be re-ordered" unless LETTERS == first
  arr_of_arrs.each {|row| define_method(row.first.gsub(' ', '_')) {row[@index] || [physical,row.first].join(" ")}}

  Attitude.all.each {|a| define_method(a.path) {[self,a].to_mbti}}

  def name; physical.capitalize; end
  def description; chemosensory; end

  def introverted; "doesn’t #{eat} much or #{walk} much"; end
  def extroverted; "#{eat.s} a lot and #{walk.s} a lot"; end
  def gsub(string)
    string.gsub('extroverted', extroverted).
    gsub('introverted', introverted).
    gsub('consume', eat).
    gsub('produce', walk)
  end

  def run; "start #{walk.ing} more and do #{eat} when you feel #{hungry}"; end
  def binge; "start #{eat.ing} more and do #{walk} when you feel #{restless}"; end
  def sit; "stop #{walk.ing} and don’t #{eat} more unless you feel #{hungry}"; end
  def fast; "stop #{eat.ing} and don’t #{walk} more unless you feel #{restless}"; end

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
