class Sign < Word

  LETTERS = %w{e i}

  def initialize(string)
    raise "#{string} is not a sign" unless self.class::LETTERS.include? string
    super
  end

  ALL = LETTERS.collect{|letter| self.new letter}
  def self.all; ALL; end
  LETTERS.each{|l| define_singleton_method(l) {all[LETTERS.index l]}}
  def other; ALL.find{|light| light != self}; end

  def index; self.class::LETTERS.index string; end
  def <=>(other); index <=> other.index; end
  def choose(klass, array); klass.new array[index]; end
  def choose_phrase(phrase); choose Phrase, phrase.map(&:words); end

end
