class Behavior

  MBTI = Response.all.collect do |response|
          Realm::ALL.collect do |realm|
            Attitude::ALL.collect do |attitude|
              [response, realm, attitude].map(&:mbti).join
            end
          end
        end.flatten

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
  def <=>(other); phase <=> other.phase; end

  def response; Response.send(mbti.first); end
  def realm; Realm.send(mbti.second); end
  def attitude; Attitude.send(mbti.third); end
  def triplet; [response, realm, attitude]; end

  def phase; response + attitude; end
  def pair; [phase, realm]; end

  class << self
    def mbtis; all.map(&:mbti); end # used in cookies
    def all; ALL; end
    def each(&block); ALL.each(&block); end
    def find(thing)
      if thing.is_a? String
        self.send(thing)
      elsif thing.is_a? Array
        if thing.size == 2
          ALL.find{|s| s.pair == thing} || ALL.find{|s| s.pair == thing.reverse}
        elsif thing.size == 3
          ALL.find{|s| s.triplet == thing}
        end
      end
    end
  end

  def flip; Behavior.find(triplet.map(&:flip)); end
  def flop; Behavior.find(triplet.map(&:flop)); end
  def opposite; flip.flop; end

  def act; realm.send(response.flip.verb); end
  def react; [act, response.prep, phase.noun].to_phrase; end
  def trigger; [triggery, nouns].to_phrase; end
  def consequence; [change, adjective, noun].to_phrase; end

  def symbolic_name; [mbti.colon, trigger.to_wbr, '=>', react.to_wbr, consequence.wrap].to_safe_phrase; end

  def method_missing(meth, *args, **kwargs, &block)
    if phase.respond_to?(meth)
      phase.send(meth)
    elsif realm.respond_to?(meth)
      realm.send(meth)
    else
      super(meth)
    end
  end


end
