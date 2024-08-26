class Behavior

  def initialize(quadrant, realm)
    @quadrant = quadrant
    @realm = realm
  end
  attr_reader :quadrant, :realm

  def pair; [@quadrant, @realm]; end
  def triplet; [@quadrant.response, @realm, @quadrant.attitude]; end
  def display; triplet.map(&:display).join; end
  alias inspect :display
  alias path :display

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
          ALL.find{|s| s.pair == thing}
        elsif thing.size == 3
          ALL.find{|s| s.triplet == thing}
        end
      end
    end
    def all; ALL; end
    def each(&block); ALL.each(&block); end
  end

  ALL.each_with_index do |instance, index|
    %w{path}.each do |thing|
      define_singleton_method(instance.send(thing)) {ALL[index]}
      define_singleton_method(instance.send(thing).downcase) {ALL[index]}
    end
  end


  def flip; Behavior.find(triplet.map(&:flip)); end
  def flop; Behavior.find(triplet.map(&:flop)); end
  def opposite; Behavior.find(triplet.map(&:opposite)); end

  # use adjective.capitalize instead of name to get '' for Generic
  def names;triplet.map(&:name); end
  def name; names.wbr; end
  def clear_name; names.join; end
  def phrase; names.to_phrase.downcase; end
  def symbolic_name; [display.colon, phrase].to_phrase; end

  def episode; @quadrant.response.episode; end
  def long; [@realm.adverb, @quadrant.long].to_phrase; end

  def examples;@realm.send(@quadrant.send_name); end
  def eg; @realm.send(@quadrant.send_action).downcase; end

end
