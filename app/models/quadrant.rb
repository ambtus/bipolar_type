class Quadrant

  def initialize(attitude, response)
    @attitude = attitude
    @response = response
  end
  attr_reader :attitude, :response

  def pair; [@response, @attitude]; end
  def display; pair.map(&:display).join; end
  alias inspect :display
  alias path :display

  ALL = Response.all.collect do |response|
          Attitude.all.collect do |attitude|
            self.new(attitude,response)
          end
        end.flatten
  def index; ALL.index self; end
  def <=>(other); self.index <=> other.index; end
  def short; %w{Flee Fight Feed Rest}[index]; end
  def verb; %w{escape win energize strengthen}[index]; end
  def long; %w{Fear Anger Agitation Lethargy}[index]; end
  def both; [short, long].slash; end
  def adjective; %w{anxious irritable agitated lethargic}[index]; end
  def class; %w{cycleB cycleU cycleG cycleR}[index]; end

  class << self
    def find(thing)
      if thing.is_a? String
        self.send(thing)
      elsif thing.is_a? Array
        ALL.find{|q| q.pair == thing }
      end
    end
    def all; ALL; end
    def each(&block); ALL.each(&block); end
    def response_order; all.values_at(1,3,0,2); end
    def shorts; response_order.map(&:short); end
    def longs; response_order.map(&:long); end

  end

  ALL.each_with_index do |instance, index|
    %w{path}.each do |thing|
      define_singleton_method(instance.send(thing)) {ALL[index]}
      define_singleton_method(instance.send(thing).downcase) {ALL[index]}
    end
  end


  def flip; Quadrant.find(pair.map(&:flip)); end
  def flop; Quadrant.find(pair.map(&:flop)); end
  def opposite; flip.flop; end
  def +(realm); Behavior.find([self, realm]); end
  def cycle; Cycle.find(self);end

  def names; pair.map(&:name); end
  def name; names.wbr; end
  def symbolic_name; [display.colon, name].to_safe_phrase; end
  def phrase; names.to_phrase; end

  def episode; [adjective, response.episode].to_phrase; end
  def trigger; response.trigger; end

end
