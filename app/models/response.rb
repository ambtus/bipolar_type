class Response

  MBTI = %w{E I}
  VERBS = %w{Use Gather}
  ADJECTIVES = %w{Manic Depressed}

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
    def all; ALL; end
    def each(&block);ALL.each(&block); end
  end

  def verb; VERBS[index]; end
  alias name :verb
  def do_something; verb.downcase; end
  def adjective; ADJECTIVES[index]; end
  def symbolic_name; [mbti.colon, name].to_phrase; end
  alias inspect :symbolic_name

  ALL.each_with_index do |instance, index|
    %w{ name verb mbti}.each do |thing|
      define_singleton_method(instance.send(thing)) {ALL[index]}
      define_singleton_method(instance.send(thing).downcase) {ALL[index]}
    end
  end

  def danger; %w{high low}[index]; end
  def episode; %w{ mania depression}[index]; end
  def focus; %w{ external internal}[index]; end
  def external?; focus == 'external'; end
  def drugs; %w{ stimulants sedatives}[index]; end

end
