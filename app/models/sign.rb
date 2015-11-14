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

  def nature; choose Word, %w{can cannot}; end

  def timing; choose Phrase, ["some time after feeling", "immediately upon feeling"].map(&:words); end

  def ease_of; choose Word, %w{easy hard}; end

end
