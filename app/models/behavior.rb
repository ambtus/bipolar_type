class Behavior

  MBTI = Direction.all.collect do |direction|
          Realm::ALL.collect do |realm|
            Attitude::ALL.collect do |attitude|
              [direction, realm, attitude].map(&:mbti).join
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

  def direction; Direction.send(mbti.first); end
  def realm; Realm.send(mbti.second); end
  def attitude; Attitude.send(mbti.third); end
  def triplet; [direction, realm, attitude]; end

  def phase; direction + attitude; end
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

  def next; Behavior.find([realm, phase.next]); end
  def previous; Behavior.find([realm, phase.previous]); end

  def trigger; [triggery, nouns].to_phrase; end
  def respond; realm.send(direction.verb) ; end
  def act; [change, adjective, noun].to_phrase; end

  def symbolic_name; [mbti.colon, trigger.to_wbr, '=>', respond, act.wrap].to_safe_phrase; end

  def actions;[realm.use, realm.get]; end

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
