class Indexable < Noun

  ########
  LETTERS = %w{x y z}
  ALL = LETTERS.collect{|letter| self.new letter}
  LETTERS.each{|l| define_singleton_method(l) {all[LETTERS.index l]}}
  ########

  def initialize(string)
    unless self.class::LETTERS.include? string
      raise "#{string} is not a #{self.class.name}"
    end
    super
  end
  alias_method :letter, :string

  def self.all; self::ALL; end

  def other; self.class.all.find{|i| i != self}; end
  def others; self.class.all.collect{|i| i != self}; end

  def index; self.class::LETTERS.index string; end
  def <=>(other); index <=> other.index; end
  def choose(klass, array)
    string = array[index]
    string == "NIL" ? nil : klass.new(string)
  end

end
