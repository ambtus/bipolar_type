class Aspect

  MBTI = %w{F S T N}
  ADJECTIVE = %w{social physical financial mental}
  CENTER = %w{soul body hands mind}
  NOUNS = %w{people places things ideas}

  GET = %w{listen eat earn watch}
  GET_EN = %w{heard eaten sold seen}
  USE = %w{talk walk spend think}
  USE_EN = %w{said done bought thought}

  ENERGY = %w{affect calories cash facts}
  STRENGTH = %w{words muscles credit theories}

  CSS = %w{red brown blue violet}

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

  def flip; self; end
  alias flop :flip
  def opposite; flip.flop; end

  def +(phase); Behavior.find([phase,self]); end
  def behaviors; Phase.all.add(self); end
  def linear_behaviors; Phase.linear.add(self); end

  constants.each do |constant|
    define_method(constant.downcase) {self.class.const_get(constant)[index]}
    if constant.downcase.to_s.plural?
      define_method(constant.downcase.to_s.singularize) {self.class.const_get(constant)[index].singularize}
    end
  end

  def adverb; adjective.ly; end

  def symbolic_name; [mbti.colon, nouns.capitalize, adjective.wrap].to_phrase; end

end
