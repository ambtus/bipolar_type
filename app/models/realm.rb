class Realm
  LETTERS = %w{t n s f}

  def initialize(letter)
    raise "#{letter} isn't an Realm" unless LETTERS.include?(letter)
    @index = LETTERS.index(letter)
    @path = letter
  end
  attr_reader :index, :path
  def <=>(other); self.index <=> other.index; end

  REALMS = LETTERS.collect{|letter| Realm.new(letter)}
  def self.all; REALMS; end
  def self.find(letter); REALMS[LETTERS.index(letter)]; end

  def +(attitude); Subtype.find(attitude.path + self.path); end
  def subtypes; Attitude.all.add(self); end

  def behaviors; Behavior.all.select{|b| b.realm == self}; end

  # touch realm.rb to reload realm.csv in development mode
  require 'csv'
  arr_of_arrs = CSV.read("config/initializers/realm.csv")
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

  def mbti; @path.upcase; end
  def name; [sensory, adjective].join("/") ; end
  def consume; [utilize, resources].join(" "); end
  def description; [consume, produce].join(" & "); end
  def emptiness; [empty, full].join("/"); end
  def quality; [good, bad].join("/"); end
  def result; [thin, fat].join("/"); end
  def zeitgebers; [zeitgeber, "times"].join(" "); end

  def replace(string)
    string.
    gsub("consumes", consume.s).
    gsub("produces", produce.s).
    gsub(/emptiness|quantity/, emptiness).
    gsub("quality", quality).
    gsub("zeitgebers", zeitgebers)
  end
end
