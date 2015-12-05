class Indexable < Noun

  ########
  LETTERS = %w{a b c d}
  ALL = LETTERS.collect{|letter| self.new letter}
  LETTERS.each{|l| define_singleton_method(l) {all[LETTERS.index l]}}
  %w{first second third fourth}.each {|i| define_singleton_method(i) {all.send(i)}}
  ########

  def initialize(string)
    unless self.class::LETTERS.include? string
      raise "#{string} is not a #{self.class.name}"
    end
    super
  end
  alias_method :letter, :string

  def self.all; self::ALL; end

  def others; self.class.all.collect{|i| i != self}; end

  def path; inspect.downcase; end

  def index; self.class::LETTERS.index string; end
  def <=>(other); index <=> other.index; end

  def index_ordinal; %w{first second third fourth}[index]; end
  def choose(klass, array)
    string = array[index]
    string == "NIL" ? nil : klass.new(string)
  end

end
