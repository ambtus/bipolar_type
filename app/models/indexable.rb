class Indexable < Noun

  ########
  LETTERS = %w{a b c d}
  def self.paths; LETTERS; end
  ALL = LETTERS.collect{|letter| self.new letter}
  def self.all; ALL; end
  LETTERS.each do |letter| 
    define_singleton_method(letter) { ALL[LETTERS.index(letter)] }
  end
  ########

  def <=>(other); self.index <=> other.index; end

  %w{first second third fourth last}.each  do |meth|
    define_singleton_method(meth) {all.send(meth)}
    define_method(meth + "?") {self.class.all.send(meth) == self}
  end
  def self.generic; self.new("generic"); end
  def self.x; self.generic; end
  def generic?; string == "generic"; end
  def ordinal; generic? ? "generic" : %w{first second third fourth}[index]; end

  def initialize(string)
    unless self.class::LETTERS.include? string
      raise "#{string} is not a #{self.class.name}" unless string == "generic"
    end
    super
  end
  def path; @string; end

  def others; self.class.all.select{|i| i != self}; end

  def index; self.class::LETTERS.index @string; end
  def <=>(other); index <=> other.index; end

  def choose(klass, array)
    string = array[index]
    string == "NIL" ? nil : klass.new(string)
  end

end
