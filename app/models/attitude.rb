class Attitude
  LETTERS = %w{ep ej ip ij}

  def initialize(letter)
    raise "#{letter} isn't an Attitude" unless LETTERS.include?(letter)
    @index = LETTERS.index(letter)
    @path = letter
  end
  attr_reader :index, :path
  def <=>(other); self.index <=> other.index; end

  ATTITUDES = LETTERS.collect{|letter| Attitude.new(letter)}
  def self.all; ATTITUDES; end
  def self.find(letter); ATTITUDES[LETTERS.index(letter)]; end

  def +(realm); Subtype.find(realm.path + self.path); end
  def subtypes; Realm.all.add(self); end

  def letters; path.scan(/./); end

  # touch attitude.rb to reload attitude.csv in development mode
  require 'csv'
  arr_of_arrs = CSV.read("config/initializers/attitude.csv")
  first = arr_of_arrs.shift
  raise "attitude.csv needs to start with path" unless first.first == "path"
  raise "attitude.csv needs to be re-ordered" unless LETTERS == first.drop(1)
  define_method("path") {LETTERS[@index]}
  arr_of_arrs.each {|row| define_method(row.first.gsub(' ', '_')) {row.drop(1)[@index]}}

  def name; [first, second].join(" ").titleize; end
  def description; [length, episode].join(" ") ; end

  def mbti; @path.upcase; end

  def inverse; Attitude.find(inverse_path); end
  def opposite; Attitude.find(opposite_path); end

#   def mbti; [first, second].map(&:first).join.upcase; end
  def method_missing(method, *args, &block)
    if method.to_s =~ /^(.*)_with_mbti$/
      [self.send($1, *args, &block), mbti.parenthetical].join(" ")
    else
      super
    end
  end

end
