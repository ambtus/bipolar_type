class Realm

  MBTI = %w{F S T N}
  ADJECTIVE = %w{affective physical financial mental}
  NOUNS = %w{people places things ideas}
  USE = %w{listen eat sell learn}
  GET = %w{communicate move buy decide}

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
  def behaviors; Behavior.all.select{|b| b.realm == self}; end

  constants.each do |constant|
    define_method(constant.downcase) {self.class.const_get(constant)[index]}
    if constant.downcase.to_s.plural?
      define_method(constant.downcase.to_s.singularize) {self.class.const_get(constant)[index].singularize}
    end
  end

  def symbolic_name; [mbti.colon, nouns.capitalize, adjective.wrap].to_phrase; end

end
