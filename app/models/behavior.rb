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
  def responden; aspect.send(direction.verb + '_en'); end

  def act; [phase.verb, adjective, noun].to_phrase; end
  def symbolic_name; [mbti.colon, respond, act.wrap].to_phrase; end

  def in_the; time == 'midday' ? 'at' : 'in the'; end
  def have_or_want; phase.verb == 'use' ? 'have the' : 'want more'; end
  def energy_or_strength; aspect.send(noun); end
  def problem
    "I #{respond} even though I do not #{have_or_want} #{energy_or_strength}."
  end

  def sick; [phase.season, phase.sick.to_noun].to_phrase; end
  def too_much; ['too much', adjective, phase.respond.ing].to_phrase; end
  def balanced
    "You #{respond} because you #{have_or_want} #{energy_or_strength}."
  end

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
