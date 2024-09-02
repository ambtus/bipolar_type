class Response

  MBTI = %w{E I}
  VERBS = %w{Use Gain}
  ADJECTIVES = %w{Stressed Exhausted}

  def initialize(mbti); @mbti = mbti; end
  attr_reader :mbti
  alias path :mbti

  def index; MBTI.index @mbti; end
  def <=>(other); self.index <=> other.index; end
  def flip; ALL.without(self).first; end
  def flop; self; end
  alias opposite :flip

  def +(attitude); Quadrant.find([attitude,self]); end

  ALL = MBTI.collect {|mbti| self.new mbti}
  class << self
    def verbs; VERBS; end
    def names; NAMES; end
    def shorts; ADJECTIVES; end
    def all; ALL; end
    def each(&block);ALL.each(&block); end
  end

  def verb; VERBS[index]; end
  alias name :verb
  def symbolic_name; [mbti.colon, name].to_phrase; end
  def do_something; verb.downcase; end
  def adjective; ADJECTIVES[index]; end
  def stressed; adjective.downcase; end
  alias inspect :symbolic_name

  ALL.each_with_index do |instance, index|
    %w{ name verb mbti}.each do |thing|
      define_singleton_method(instance.send(thing)) {ALL[index]}
      define_singleton_method(instance.send(thing).downcase) {ALL[index]}
    end
  end

  def external?; index == 0; end
  def danger; %w{stress exhaustion}[index]; end
  def state; %w{ manic depressed}[index]; end
  def episode; %w{ mania depression}[index]; end
  def focus; %w{ external internal}[index]; end
  def external?; focus == 'external'; end
  def drugs; %w{ stimulants sedatives}[index]; end

end
