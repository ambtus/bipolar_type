class Realm
  LETTERS = %w{s f t n}

  def initialize(letter)
    raise "#{letter} isn't an Realm" unless LETTERS.include?(letter)
    @index = LETTERS.index(letter)
    @path = letter
  end
  attr_reader :index

  REALMS = LETTERS.collect{|letter| Realm.new(letter)}
  def self.all; REALMS; end
  def self.find(letter); REALMS[LETTERS.index(letter)]; end

  def +(attitude); Subtype.find(attitude.path + self.path); end
  def subtypes; Attitude.all.add(self); end
  Attitude.all.each {|a| define_method(a.path) {self + a}}

  def mbti; @path.upcase; end

  def name; [sensory, adjective].join("/") ; end


  require 'csv'
  arr_of_arrs = CSV.read("config/initializers/realm.csv", :skip_blanks => true, :skip_lines => /^#/)
  first = arr_of_arrs.shift
  raise "realm.csv needs to start with path" unless first.first == "path"
  raise "realm.csv needs to be re-ordered" unless LETTERS == first.drop(1)
  define_method("path") {LETTERS[@index]}
  arr_of_arrs.each {|row| define_method(row.first.gsub(' ', '_')) {row.drop(1)[@index]}}

  def method_missing(method, *args, &block)
    if method.to_s =~ /^(.*)_with_mbti$/
      [self.send($1, *args, &block), mbti.parenthetical].join(" ")
    else
      super
    end
  end

end
