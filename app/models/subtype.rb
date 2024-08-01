class Subtype

  def initialize(triplet, position)
    @triplet = triplet
    @position = position
  end
  attr_reader :triplet, :position

  def behavior; triplet.behavior; end
  def realm; triplet.realm; end

  def pair; [@triplet, @position]; end
  def <=>(other); pair <=> other.pair; end

  def path; pair.map(&:path).join; end
  def mbti; pair.map(&:mbti).join; end
  def display; pair.map(&:display).join; end
  alias inspect :display

  def names;[@position.name, @triplet.name]; end
  def name; names.wbr; end
  def symbolic_name; [display.colon, name].to_safe_phrase; end

  ALL = Triplet.all.collect do |triplet|
          Position.all.collect do |position|
            self.new(triplet,position)
          end
        end.flatten

  class << self
    def find(thing)
      if thing.is_a? String
        self.send(thing)
      elsif thing.is_a? Array
        if thing.length == 2
          ALL.find{|s| s.triplet == thing.first && s.position == thing.second}
        elsif thing.length == 3
          ALL.find{|s| s.behavior == thing.first && s.realm == thing.second && s.position == thing.third}
        end
      end
    end
    def all; ALL; end
    def each(&block); ALL.each(&block); end
    def dominant(realm, index)
      behavior = Behavior.sort_order[index]
      Subtype.find([behavior, realm, Position.dominant])
    end
  end

  ALL.each_with_index do |instance, index|
    %w{path}.each do |thing|
      define_singleton_method(instance.send(thing)) {ALL[index]}
      define_singleton_method(instance.send(thing).downcase) {ALL[index]}
    end
  end

  def inferior?; @position.inferior?; end

  def next; Subtype.find([@triplet.next, @position.next]); end
  def opposite; self.next.next; end
  def previous; opposite.next; end

  def cycle; Cycle.find(self); end
  def sample_behavior;[@triplet.sample_behavior, @position.adverb].to_phrase; end

end
