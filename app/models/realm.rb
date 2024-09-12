class Realm

  MBTI = %w{F S T N}
  ADJECTIVE = %w{affective physical financial mental}
  NOUNS = %w{people places things ideas}

  GET = %w{listen eat sell look}
  GET_PREP = %w{to in \  at}
  USE = %w{talk walk buy think}
  USE_PREP = %w{to around \  about}

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
  def behaviors; Phase.linear.add(self); end

  constants.each do |constant|
    define_method(constant.downcase) {self.class.const_get(constant)[index]}
    if constant.downcase.to_s.plural?
      define_method(constant.downcase.to_s.singularize) {self.class.const_get(constant)[index].singularize}
    end
  end

  def intake; [get, get_prep].to_phrase; end
  def output; [use, use_prep].to_phrase; end

  def symbolic_name; [mbti.colon, nouns.capitalize, adjective.wrap].to_phrase; end

end
