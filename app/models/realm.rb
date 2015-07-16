class Realm
  LETTERS = %w{s f t n}

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

  def +(attitude); Behavior.find(attitude.path + self.path); end
  def behaviors; Attitude.all.add(self); end

  # touch realm.rb to reload realm.csv in development mode
  require 'csv'
  arr_of_arrs = CSV.read("config/initializers/realm.csv")
  first = arr_of_arrs.shift
  raise "realm.csv needs to start with path" unless first.first == "path"
  raise "realm.csv needs to be re-ordered" unless LETTERS == first.drop(1)
  define_method("path") {LETTERS[@index]}
  arr_of_arrs.each {|row| define_method(row.first.gsub(' ', '_')) {row.drop(1)[@index]}}

  def mbti; @path.upcase; end
  def method_missing(method, *args, &block)
    if method.to_s =~ /^(.*)_with_mbti$/
      [self.send($1, *args, &block), mbti.parenthetical].join(" ")
    else
      super
    end
  end

  def name; [sensory, adjective].join("/") ; end
  def consume; [get, resources].join(" "); end
  def description; [consume, produce].join(" & "); end
  def imbalance; [empty, full].join("/"); end

  def quality; [good, bad].join(" & "); end
  def quantity; [abundance, scarcity].join(" & "); end
  def needs; [gaining, losing].join(" & "); end
  def zeitgebers; [ctime, ptime].join(" & "); end

  def replace(string)
    string.
    gsub("consumes", consume.s).
    gsub("produces", produce.s).
    gsub("quality", quality).
    gsub("quantity", quantity).
    gsub("needs", needs).
    gsub("zeitgebers", zeitgebers)
  end
end
