class Indexable < Noun

  ########
  LETTERS = %w{a b c d x}
  ALL = LETTERS.collect{|letter| self.new letter}
  def self.all; self::ALL; end
  all.each { |i| define_singleton_method(i.path) {all[LETTERS.index i.string]} }
  ########

  %w{first second third fourth generic}.each {|i| define_singleton_method(i) {all.send(i)}}
  def ordinal; %w{first second third fourth generic}[index]; end

  def initialize(string)
    unless self.class::LETTERS.include? string
      raise "#{string} is not a #{self.class.name}"
    end
    super
  end
  alias_method :letter, :string

  def others; self.class.all.collect{|i| i != self}; end

  def path; to_s.downcase; end
  def self.paths; all.map(&:path); end

  def index; self.class::LETTERS.index string; end
  def <=>(other); index <=> other.index; end

  def choose(klass, array)
    if ordinal == "generic"
      klass.new(caller_locations(1,1)[0].label.gsub('_', ' '))
    else
      string = array[index]
      string == "NIL" ? nil : klass.new(string)
    end
  end

end
