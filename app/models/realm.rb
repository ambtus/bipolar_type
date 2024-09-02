class Realm

  MBTI = %w{S T N F}
  NOUNS = %w{ Places Things Ideas People}
  NAMES = %w{ Physical Financial Mental Affective}

  def initialize(mbti); @mbti = mbti; end
  attr_reader :mbti
  alias path :mbti

  def index; MBTI.index @mbti; end
  def <=>(other); self.index <=> other.index; end
  def flip; self; end
  alias flop :flip
  alias opposite :flip

  def +(quadrant); Behavior.find([quadrant, self]); end

  ALL = MBTI.collect {|mbti| self.new mbti}
  class << self
    def nouns; NOUNS; end
    def names; NAMES; end
    def all; ALL; end
    def each(&block);ALL.each(&block); end
  end

  def nouns; NOUNS[index]; end
  def noun; nouns.singularize; end
  def name; NAMES[index]; end
  def adjective; name.downcase; end
  def adverb; adjective.ly; end
  def symbolic_name; [mbti.colon, name].to_phrase; end
  alias inspect :symbolic_name

  ALL.each_with_index do |instance, index|
    %w{ name noun mbti}.each do |thing|
      define_singleton_method(instance.send(thing)) {ALL[index]}
      define_singleton_method(instance.send(thing).downcase) {ALL[index]}
    end
  end


end
