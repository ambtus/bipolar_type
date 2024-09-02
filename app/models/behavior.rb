class Behavior

  def initialize(quadrant, realm)
    @quadrant = quadrant
    @realm = realm
  end
  attr_reader :quadrant, :realm

  def pair; [@quadrant, @realm]; end
  def triplet; [@quadrant.response, @realm, @quadrant.attitude]; end
  def mbti; triplet.map(&:mbti).join; end
  alias inspect :mbti
  alias path :mbti

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

  def names;triplet.map(&:name); end
  def name; names.wbr; end
  def clear_name; names.join; end
  def phrase; names.to_phrase.downcase; end
  def symbolic_name; [mbti.colon, name].to_safe_phrase; end
  def problems; ['Excess', realm.name, quadrant.short]; end
  def problem; problems.wbr; end
  def symbolic_problem; [mbti.colon, problem].to_safe_phrase; end
  def episode; [response.state.capitalize, realm.name, attitude.noun].wbr; end
  def danger; quadrant.danger; end
  def stressed;[realm.adverb, quadrant.stressed].to_phrase; end

  def do_something; realm.send(quadrant.do_something); end

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
