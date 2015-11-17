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

  def self.all; self::ALL; end

  def other; ALL.find{|i| i != self}; end
  def others; ALL.collect{|i| i != self}; end

  def index; self.class::LETTERS.index string; end
  def <=>(other); index <=> other.index; end
  def choose(klass, array); klass.new array[index]; end

end