class Response

  MBTI = %w{E I}
  PHRASE = %w{fight-or-flight rest-and-digest}
  ADJECTIVE = %w{manic depressed}
  EPISODE = %w{mania depression}
  NOUN = %w{loss gain}
  VERB = %w{use get}
  DRUGS = %w{stimulants sedatives}
  INTERJECTION = %w{rev\ up calm\ down}

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
    def each(&block);ALL.each(&block); end
  end

  def flip; ALL.without(self).first; end
  def flop; self; end
  def opposite; flip.flop; end

  def +(attitude); Quadrant.find([attitude,self]); end

  constants.each do |constant|
    define_method(constant.downcase) {self.class.const_get(constant)[index]}
    if constant.downcase.to_s.plural?
      define_method(constant.downcase.to_s.singularize) {self.class.const_get(constant)[index].singularize}
    end
  end

  def external?; index == 0; end

    def name; [adjective.capitalize.colon, phrase].to_phrase; end

  def symbolic_name; [mbti.colon, adjective.capitalize, phrase.wrap].to_phrase; end

end
