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

  ALL = Attitude.all.collect do |attitude|
          Response::ALL.collect do |response|
            self.new(attitude,response)
          end
        end.flatten
  def index; ALL.index self; end
  def short; %w{Rest Fight Feed Flee}[index]; end
  def verb; short.downcase; end
  def long; %w{Sloth Wrath Greed Phobia}[index]; end
  def both; [short, long].slash; end

  class << self
    def find(thing)
      if thing.is_a? String
        self.send(thing)
      elsif thing.is_a? Array
        ALL.find{|s| s.attitude == thing.first &&  s.response == thing.second}
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
  def opposite; Quadrant.find(pair.map(&:opposite)); end
  def +(realm); Behavior.find([self, realm]); end
  def cycle; Cycle.find(self);end

  def names; pair.map(&:name); end
  def name; names.wbr; end
  def symbolic_name; [display.colon, name].to_safe_phrase; end
  def phrase; names.to_phrase; end


  def examples;@response.send(@attitude.send_name); end
  def eg; @response.send(@attitude.send_action).downcase; end

end
