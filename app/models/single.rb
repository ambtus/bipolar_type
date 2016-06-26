class Single < Noun

  ########
  ACRONYMS = %w{a b c d}
  ALL = ACRONYMS.collect {|letter| self.new letter}
  ACRONYMS.each {|letter| define_singleton_method(letter) { ALL[ACRONYMS.index(letter)] } }
  ########

  def self.all; self::ALL; end
  def self.paths; self::ACRONYMS; end

  %w{first second third fourth}.each  do |meth|
    define_singleton_method(meth) {all.send(meth)}
  end
  def self.generic; self.new("x"); end
  def self.x; self.generic; end

  def initialize(letter)
    unless self.class::ACRONYMS.include? letter
      raise "#{letter} is not a #{self.class.name}" unless letter == "x"
    end
    super
  end

  def path; @string; end

  def others
    raise "not enough members" unless self.class.all.size > 2
    self.class.all.select{|i| i != self}
  end
  def other
    raise "too many members" unless self.class.all.size == 2
    self.class.all.select{|i| i != self}.first
  end

  def index; self.class::ACRONYMS.index @string; end
  def <=>(other); index <=> other.index; end
  def ordinal; %w{first second third fourth}[index]; end

  def generic?; @string == "x"; end
  def choose(klass, array) 
    string = generic? ? caller_locations(1,1)[0].label : array[index]
    string == "NIL" ? nil : klass.new(string)
  end

end
