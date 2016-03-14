class Indexable < Noun

  ########
  IDENTIFIERS = %w{a b c d}
  def self.paths; IDENTIFIERS; end
  ALL = IDENTIFIERS.collect{|letter| self.new letter}
  def self.all; self::ALL; end
  all.each { |i| define_singleton_method(i.path) {all[IDENTIFIERS.index i.string]} }
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
    unless self.class::IDENTIFIERS.include? string
      raise "#{string} is not a #{self.class.name}" unless string == "generic"
    end
    super
  end
  alias_method :letter, :string
  def path; string; end

  def others; self.class.all.select{|i| i != self}; end

  def index
    if string == "generic"
      self.class::IDENTIFIERS.size + 1
    else
      self.class::IDENTIFIERS.index string
    end
  end
  def <=>(other); index <=> other.index; end

  def choose(klass, array)
    if ordinal == "generic"
      method_name = caller_locations(1,1)[0].label.gsub('_', ' ')
      return nil if method_name.match(/ helper$/)
      klass == Phrase ? klass.new(method_name.split) : klass.new(method_name)
    else
      string = array[index]
      string == "NIL" ? nil : klass.new(string)
    end
  end

end
