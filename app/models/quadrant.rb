class Quadrant

  VERBS = %w{Flee Fight Digest Rest}

  def initialize(mbti); @mbti = mbti; end
  attr_reader :mbti
  alias path :mbti

  def index; ALL.index self; end
  def <=>(other); self.index <=> other.index; end
  def flip; Quadrant.find(pair.map(&:flip)); end
  def flop; Quadrant.find(pair.map(&:flop)); end
  def opposite; flip.flop; end

  def +(realm); Behavior.find([self, realm]); end
  def behaviors; Behavior.all.select{|b| b.quadrant == self}; end

  ALL = Response::MBTI.collect do |response|
          Attitude::MBTI.collect do |attitude|
            self.new(response+attitude)
          end
        end.flatten
  MBTI = ALL.map(&:mbti)

  class << self
    def verbs; VERBS; end
    def titles; ALL.map(&:title); end
    def names; ALL.map(&:name); end
    def all; ALL; end
    def each(&block);ALL.each(&block); end
    def linear; ALL.values_at(2,0,1,3); end
    def find(thing)
      if thing.is_a? String
        self.send(thing)
      elsif thing.is_a? Array
        ALL.find{|q| q.pair == thing } || ALL.find{|q| q.pair == thing.reverse}
      end
    end
  end

  def short; VERBS[index]; end
  def verb; short.downcase; end
  alias css :verb
  def name; pair.map(&:name).wbr; end
  def words; [response.verb, attitude.noun]; end
  def phrase; [short, words.to_phrase].and.downcase; end
  def title; words.wbr; end
  def symbolic_name; [mbti.colon, phrase].to_safe_phrase; end
  def clean_title; words.join; end
  def inspect; [mbti.colon, clean_title].to_phrase; end

  ALL.each_with_index do |instance, index|
    %w{ verb mbti }.each do |thing|
      define_singleton_method(instance.send(thing)) {ALL[index]}
      define_singleton_method(instance.send(thing).downcase) {ALL[index]}
    end
  end

  def response; Response.send(mbti.first); end
  def attitude; Attitude.send(mbti.second); end
  def pair; [response, attitude]; end

  def episode; [response.state.capitalize, attitude.noun].wbr; end

  def stressed; %w{afraid angry empty worn\ out}[index]; end


  def method_missing(meth, *args, **kwargs, &block)
    if response.respond_to?(meth)
      response.send(meth)
    elsif attitude.respond_to?(meth)
      attitude.send(meth)
    else
      super(meth)
    end
  end


  def goal; %w{escape win energize recover}[index]; end
  def bipolar; response.adjective; end


  def weekly; %w{Wednesday Friday Monday weekend}[index]; end
  def daily; %w{day afternoon morning evening}[index]; end
  def yearly; %w{summer fall spring winter}[index]; end
  def period; [yearly, daily].to_phrase; end

  def position; %w{early late the\ start the\ end}[index]; end
  def preposition; external? ? 'in' : 'of'; end
  def cycle_name; [position.capitalize, preposition, 'the cycle'].to_phrase; end

  def relative; index.even? ? 'early' : 'late'; end



end
