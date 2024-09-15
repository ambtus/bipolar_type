class Behavior

  MBTI = Direction.all.collect do |direction|
          Aspect::ALL.collect do |aspect|
            Attitude::ALL.collect do |attitude|
              [direction, aspect, attitude].map(&:mbti).join
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
  def aspect; Aspect.send(mbti.second); end
  def attitude; Attitude.send(mbti.third); end
  def triplet; [direction, aspect, attitude]; end

  def phase; direction + attitude; end
  def pair; [phase, aspect]; end

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

  def next; Behavior.find([aspect, phase.next]); end
  def previous; Behavior.find([aspect, phase.previous]); end

  def respond; aspect.send(direction.verb) ; end

  def symbolic_name; [mbti.colon, triggered.to_wbr, '=>', respond, act.wrap].to_safe_phrase; end

  def prep; aspect.send(direction.verb + '_prep'); end
  def respond_to; [respond, prep].to_phrase; end
  def responden; aspect.send(direction.verb + '_en'); end

  def answer; "I #{respond} too much, but not because I am #{flop.induced.to_adjective}."; end

  def method_missing(meth, *args, **kwargs, &block)
    if phase.respond_to?(meth)
      phase.send(meth)
    elsif aspect.respond_to?(meth)
      aspect.send(meth)
    else
      super(meth)
    end
  end


end
