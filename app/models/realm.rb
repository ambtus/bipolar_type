class Realm

  MBTI = %w{F S T N}
  ADJECTIVE = %w{affective physical financial mental}
  NOUNS = %w{people places things ideas}
  TRANSIENTS = %w{whys foods shelters hows}
  RESERVES = %w{attachments fat savings knowledge}
  POWER = %w{vocabulary muscles credit rules}
  USE = %w{listen eat collect learn}
  GET = %w{communicate move spend decide}

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

  def flip; self; end
  alias flop :flip
  def opposite; flip.flop; end

  def +(quadrant); Behavior.find([quadrant, self]); end

  constants.each do |constant|
    define_method(constant.downcase) {self.class.const_get(constant)[index]}
    if constant.downcase.to_s.plural?
      define_method(constant.downcase.to_s.singularize) {self.class.const_get(constant)[index].singularize}
    end
  end

  def adverb; adjective.ly; end

  def phrase; [nouns, 'and their', transients].to_phrase; end
  def assets; [adjective, 'strength & energy'].to_phrase; end
  def symbolic_name; [mbti.colon, assets.capitalize, phrase.wrap].to_phrase; end

end
