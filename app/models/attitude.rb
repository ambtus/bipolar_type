class Attitude

  MBTI = %w{P J}
  NOUNS = %w{Energy Strength}
  ADJECTIVES = %w{Prey Predator}

  def initialize(mbti); @mbti = mbti; end
  attr_reader :mbti
  alias path :mbti

  def index; MBTI.index @mbti; end
  def <=>(other); self.index <=> other.index; end
  def flip; self; end
  def flop; ALL.without(self).first; end
  alias opposite :flop

  def +(response); Quadrant.find([response, self]); end

  ALL = MBTI.collect {|mbti| self.new mbti}
  class << self
    def nouns; NOUNS; end
    def names; NAMES; end
    def shorts; ADJECTIVES; end
    def all; ALL; end
    def each(&block);ALL.each(&block); end
  end

  def adjective; ADJECTIVES[index]; end
  def noun; NOUNS[index]; end
  alias name :noun
  def symbolic_name; [mbti.colon, noun].to_phrase; end
  alias inspect :symbolic_name

  ALL.each_with_index do |instance, index|
    %w{ name adjective mbti}.each do |thing|
      define_singleton_method(instance.send(thing)) {ALL[index]}
      define_singleton_method(instance.send(thing).downcase) {ALL[index]}
    end
  end

  def whose; %w{bad good}[index]; end
  def whom; %w{you me}[index]; end
  def which; %w{another this}[index]; end

end
