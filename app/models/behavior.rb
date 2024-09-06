class Behavior

  def initialize(quadrant, realm)
    @quadrant = quadrant
    @realm = realm
  end
  attr_reader :quadrant, :realm

  def pair; [@quadrant, @realm]; end
  def triplet; [@quadrant.response, @realm, @quadrant.attitude]; end
  def mbti; triplet.map(&:mbti).join; end
  alias path :mbti
  alias inspect :mbti

  def <=>(other); quadrant <=> other.quadrant; end

  ALL = Quadrant.all.collect do |quadrant|
          Realm::ALL.collect do |realm|
            self.new(quadrant,realm)
          end
        end.flatten

  class << self
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
    def all; ALL; end
    def each(&block); ALL.each(&block); end
    def mbtis; all.map(&:mbti); end
  end

  ALL.each_with_index do |instance, index|
    %w{path}.each do |thing|
      define_singleton_method(instance.send(thing)) {ALL[index]}
      define_singleton_method(instance.send(thing).downcase) {ALL[index]}
    end
  end

  def flip; Behavior.find(triplet.map(&:flip)); end
  def flop; Behavior.find(triplet.map(&:flop)); end
  def opposite; flip.flop; end

  def targets; realm.send(quadrant.targets); end
  def problem; [which, targets].to_phrase; end
  def accept; realm.send(response.flip.verb); end
  def drive; [accept, attitude.adverb].to_phrase; end
  def rebalance; [change, realm.send(quadrant.assets)].to_phrase; end

  def name; [problem.to_wbr.colon, drive.to_wbr].to_safe_phrase; end
  def symbolic_name; [mbti.colon, problem.to_wbr, drive.to_wbr.wrap].to_safe_phrase; end

  def method_missing(meth, *args, **kwargs, &block)
    if quadrant.respond_to?(meth)
      quadrant.send(meth)
    elsif realm.respond_to?(meth)
      realm.send(meth)
    else
      super(meth)
    end
  end


end
