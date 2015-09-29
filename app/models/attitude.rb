class Attitude
  LETTERS = %w{ep ej ij ip}

  def initialize(letter)
    raise "#{letter} isn't an Attitude" unless LETTERS.include?(letter)
    @index = LETTERS.index(letter)
    @path = letter
  end
  attr_reader :index, :path
  def <=>(other); self.index <=> other.index; end
  def mbti; path.upcase; end

  ATTITUDES = LETTERS.collect{|letter| Attitude.new(letter)}
  def self.all; ATTITUDES; end
  def self.find(letter); ATTITUDES[LETTERS.index(letter)]; end

  def +(realm); Subtype.find(realm.path + self.path); end
  def subtypes; Realm.all.add(self); end

  # touch attitude.rb to reload attitude.csv in development mode
  require 'csv'
  arr_of_arrs = CSV.read("config/initializers/attitude.csv")
  first = arr_of_arrs.shift
  raise "attitude.csv needs to be re-ordered" unless LETTERS == first
  arr_of_arrs.each {|row| define_method(row.first.gsub(' ', '_')) {row[@index]}}

  Realm.all.each {|r| define_method(r.path) {[self,r].to_mbti}}

  def name; fat.titleize; end
  def consume; insensitive == "insensitive" ? "consuming is relaxing" : "consuming is stressful"; end
  def produce; consumer == "consumer" ? "producing was discouraged" : "producing was encouraged"; end
  def description; [consume, produce].join('<br />').html_safe; end

  def self.square; all.values_at(0,1,3,2); end

  def method_missing(method, *args, &block)
    if method.to_s =~ /^(.*)_with_mbti$/
      [self.send($1, *args, &block).gsub('<br />', " & "), mbti.parenthetical].join(" ")
    else
      super
    end
  end

end
