class Quadrant

  MBTI = %w{EP EJ IP IJ}
  VERB = %w{flee fight digest rest}
  CHANGE = %w{lose strain gain heal}
  CSS = %w{yellow orange green violet}
  ORDINAL = %w{second third first fourth}
  GOAL = %w{escape win refuel recover}
  STRESSED = %w{afraid angry hungry worn\ out}
  WHICH = %w{frightening irritating appealing rewarding}

  TIME = %w{noon afternoon morning night}
  DAY = %w{wednesday friday monday weekend}
  MOON = %w{full waning waxing new}
  SEASON = %w{summer fall spring winter}
  AGE = %w{adolescent adult child elder}

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

  def response; Response.send(mbti.first); end
  def attitude; Attitude.send(mbti.second); end
  def pair; [response, attitude]; end

  class << self
    def linear; ALL.values_at(2,0,1,3); end
    def all; ALL; end
    def each(&block);ALL.each(&block); end
    def find(thing)
      if thing.is_a? String
        self.send(thing)
      elsif thing.is_a? Array
        ALL.find{|q| q.pair == thing } || ALL.find{|q| q.pair == thing.reverse}
      end
    end
  end

  def flip; Quadrant.find(pair.map(&:flip)); end
  def flop; Quadrant.find(pair.map(&:flop)); end
  def opposite; flip.flop; end

  def +(realm); Behavior.find([self, realm]); end
  def behaviors; Behavior.all.select{|b| b.quadrant == self}; end

  constants.each do |constant|
    define_method(constant.downcase) {self.class.const_get(constant)[index]}
    if constant.downcase.to_s.plural?
      define_method(constant.downcase.to_s.singularize) {self.class.const_get(constant)[index].singularize}
    end
  end

  def linear_index; self.class.linear.index(self); end
  def next_phase; self.class.linear[linear_index + 1] || self.class.linear.first; end


  def times; [time, day, moon + ' moon', season, age].map(&:titleize); end

  def rebalance; [change, assets].to_phrase; end
  def targets; index < 2 ? 'nouns' : 'transients' ; end

  def adjective; response.adjective; end
  alias sick :adjective
  def noun; attitude.noun; end
  def phrase; [response.verb, noun].to_phrase; end

  def problem; [adjective, noun].to_phrase; end
  def drive; [verb, 'to', goal].to_phrase; end

  def name; [problem.to_wbr.colon, drive.to_wbr].to_safe_phrase; end
  def symbolic_name; [mbti.colon, problem.to_wbr, drive.to_wbr.wrap].to_safe_phrase; end

  def method_missing(meth, *args, **kwargs, &block)
    if response.respond_to?(meth)
      response.send(meth)
    elsif attitude.respond_to?(meth)
      attitude.send(meth)
    else
      super(meth)
    end
  end

end
