class Attitude

  MBTI = %w{P J}
  VERB = %w{defend attack}
  NOUN = %w{energy strength}
  ASSETS = %w{reserves power}
  ANIMAL = %w{herbivore carnivore}
  ADJECTIVE = %w{fast powerful}
  ADVERB = %w{quickly slowly}

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
  def flop; ALL.without(self).first; end
  def opposite; flip.flop; end

  def +(response); Quadrant.find([response, self]); end

  constants.each do |constant|
    define_method(constant.downcase) {self.class.const_get(constant)[index]}
    if constant.downcase.to_s.plural?
      define_method(constant.downcase.to_s.singularize) {self.class.const_get(constant)[index].singularize}
    end
  end

  def name; [noun.capitalize.colon, assets].to_phrase; end
  def symbolic_name; [mbti.colon, noun.capitalize, assets.wrap].to_phrase; end

end
