class Indexable < Noun

  ########
  IDENTIFIERS = %w{a b c d}
  def self.paths; IDENTIFIERS; end
  ALL = IDENTIFIERS.collect{|letter| self.new letter}
  def self.all; self::ALL; end
  all.each { |i| define_singleton_method(i.path) {all[IDENTIFIERS.index i.string]} }
  ########

  %w{first second third fourth last}.each {|i| define_singleton_method(i) {all.send(i)}}
  def self.generic; self.new("X"); end
  def self.x; self.generic; end
  def generic?; string == "X"; end
  def ordinal; generic? ? "generic" : %w{first second third fourth}[index]; end

  def initialize(string)
    unless self.class::IDENTIFIERS.include? string
      raise "#{string} is not a #{self.class.name}" unless string == "X"
    end
    super
  end
  alias_method :letter, :string
  def path; string; end

  def others; self.class.all.select{|i| i != self}; end

  def index; self.class::IDENTIFIERS.index string; end
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
