class Direction

  MBTI = %w{E I}
  PHRASE = %w{fight/flight rest/digest}
  VERB = %w{use get}
  SICK = %w{manic depressed}

  def initialize(mbti); @mbti = mbti; end
  attr_reader :mbti
  alias path :mbti
  alias inspect :mbti

  ALL = MBTI.collect {|mbti| self.new mbti}
  MBTI.each_with_index do |mbti, index|
    define_singleton_method(mbti) {ALL[index]}
    define_singleton_method(mbti.downcase) {ALL[index]}
  end
  def index; MBTI.index @mbti; end
  def <=>(other); self.index <=> other.index; end

  class << self
    def all; ALL; end
    def each(&block); ALL.each(&block); end
  end

  def flip; ALL.without(self).first; end
  def flop; self; end
  def opposite; flip.flop; end

  def +(attitude); Phase.find([attitude,self]); end

  constants.each do |constant|
    define_method(constant.downcase) {self.class.const_get(constant)[index]}
    if constant.downcase.to_s.plural?
      define_method(constant.downcase.to_s.singularize) {self.class.const_get(constant)[index].singularize}
    end
  end

end
