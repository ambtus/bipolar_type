class Attitude
  LETTERS = %w{e p j i}

  def initialize(letter)
    raise "#{letter} isn't an Attitude" unless LETTERS.include?(letter)
    @index = LETTERS.index(letter)
    @path = letter
  end
  attr_reader :path, :index

  ATTITUDES = LETTERS.collect{|letter| Attitude.new(letter)}
  def self.all; ATTITUDES; end
  def self.find(letter); ATTITUDES[LETTERS.index(letter)]; end

  def <=>(other); self.index <=> other.index; end

  def self.matrix_ordered; %w{e j p i}.collect{|l| Attitude.find(l)}; end

  def +(realm); Subtype.find(self.path + realm.path); end
  def subtypes; Realm.all.add(self); end

  def after; ATTITUDES[(@index + 1).modulo(4)]; end
  def opposite; ATTITUDES[(@index + 2).modulo(4)]; end
  def before; ATTITUDES[(@index - 1).modulo(4)]; end


  def mbti; path.upcase; end

  def attitude; %w{bursty_output bursty_input steady_output steady_input}[@index]; end
  def name; attitude.gsub("_", " "); end
  def stage; %w{infancy childhood adolescence adulthood}[@index]; end
  def state; %w{thin fat weak strong}[@index]; end

  def output?; @index.even?; end
  def direction; output? ? "loss" : "gain"; end

  def fast?; @index < 2; end
  def speed; fast? ? "quick" : "slow"; end

  def ordered_sequence; [self, after, opposite, before]; end
  def output_sequence; [self, after, before, opposite]; end
  def input_sequence; [self, before, after, opposite]; end
  def sequence; output? ? output_sequence : input_sequence; end

  private
  def method_missing(method, *args, &block)
    if method.to_s =~ /^(.*)_with_mbti$/
      [self.send($1, *args, &block), mbti.parenthetical].join(" ")
    else
      super
    end
  end

end
