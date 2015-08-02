class Realm
  LETTERS = %w{t f n s}

  def initialize(letter)
    raise "#{letter} isn't an Realm" unless LETTERS.include?(letter)
    @index = LETTERS.index(letter)
    @path = letter
  end
  attr_reader :index

  REALMS = LETTERS.collect{|letter| Realm.new(letter)}
  def self.all; REALMS; end
  def self.find(letter); REALMS[LETTERS.index(letter)]; end

  def +(attitude); Subtype.find(self.path + attitude.path); end
  def subtypes; Attitude.all.add(self); end

  # touch realm.rb to reload realm.csv in development mode
  require 'csv'
  arr_of_arrs = CSV.read("config/initializers/realm.csv")
  first = arr_of_arrs.shift
  raise "realm.csv needs to start with path" unless first.first == "path"
  raise "realm.csv needs to be re-ordered" unless LETTERS == first.drop(1)
  define_method("path") {LETTERS[@index]}
  arr_of_arrs.each {|row| define_method(row.first.gsub(' ', '_')) {row.drop(1)[@index]}}

  def mbti; path.upcase; end

  def adjective; name.downcase; end
  def adverb; adjective.ly; end

#   def mbti; name.first; end
  def method_missing(method, *args, &block)
    if method.to_s =~ /^(.*)_with_mbti$/
      [self.send($1, *args, &block), mbti.parenthetical].join(" ")
    else
      super
    end
  end

end
