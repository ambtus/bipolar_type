class Realm
  LETTERS = %w{sf nt st nf}

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

  def +(attitude); Subtype.find(attitude.path + self.path); end
  def subtypes; Attitude.all.add(self); end

  # touch realm.rb to reload realm.csv in development mode
  require 'csv'
  arr_of_arrs = CSV.read("config/initializers/realm.csv")
  first = arr_of_arrs.shift
  raise "realm.csv needs to be re-ordered" unless LETTERS == first
  arr_of_arrs.each {|row| define_method(row.first.gsub(' ', '_')) {row[@index]}}

  Attitude.all.each {|a| define_method(a.path) {[self,a].to_mbti}}

  def name; physical.capitalize; end
  def consume; [eat, meals].join(" "); end
  def description; [consume, walk].join(" & "); end

  def method_missing(method, *args, &block)
    if method.to_s =~ /^(.*)_with_mbti$/
      [self.send($1, *args, &block), mbti.parenthetical].join(" ")
    else
      super
    end
  end

end
