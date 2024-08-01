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
  def mbti; pair.reverse.map(&:mbti).wbr; end
  def display; pair.map(&:display).join; end
  alias inspect :display

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

  def next; Subtype.find([@triplet.next, @position.next]); end
  def opposite; self.next.next; end
  def previous; opposite.next; end

  def cycle; Cycle.find(self); end

  def names;[@position.name, *@triplet.names]; end
  def name; names.wbr; end
  def symbolic_name; [display.colon, name].to_safe_phrase; end

   def method_missing(meth, *arguments, &block)
    if realm.respond_to?(meth)
      realm.send(meth, *arguments, &block)
    elsif behavior.respond_to?(meth)
      behavior.send(meth, *arguments, &block)
    elsif position.respond_to?(meth)
      position.send(meth, *arguments, &block)
    elsif triplet.respond_to?(meth)
      triplet.send(meth, *arguments, &block)
    else
      super
    end
  end

end
