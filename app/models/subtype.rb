class Subtype

  def initialize(triplet, priority)
    @triplet = triplet
    @priority = priority
  end
  attr_reader :triplet, :priority

  def behavior; triplet.behavior; end
  def realm; triplet.realm; end

  def pair; [@triplet, @priority]; end
  def <=>(other); pair <=> other.pair; end

  def path; pair.map(&:path).join; end
  def mbti; pair.reverse.map(&:mbti).wbr; end
  def display; pair.map(&:display).join; end
  alias inspect :display

  def class_names; [cycle.type, priority.type].to_phrase; end

  ALL = Triplet.all.collect do |triplet|
          Priority.all.collect do |priority|
            self.new(triplet,priority)
          end
        end.flatten

  class << self
    def find(thing)
      if thing.is_a? String
        self.send(thing)
      elsif thing.is_a? Array
        if thing.length == 2
          ALL.find{|s| s.triplet == thing.first && s.priority == thing.second}
        elsif thing.length == 3
          ALL.find{|s| s.behavior == thing.first && s.realm == thing.second && s.priority == thing.third}
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

  def flip; Subtype.find(pair.map(&:flip)); end
  def flop; Subtype.find(pair.map(&:flop)); end
  def opposite; Subtype.find(pair.map(&:opposite)); end

  def cycle; Cycle.find(self); end
  def cycle_type; cycle.type; end

  def eg; [display.colon, priority.eg, ('by' unless priority.last?), triplet.eg.downcase.ing].to_phrase; end

  def names;[*@triplet.names, @priority.name, ]; end
  def name; names.wbr; end
  def symbolic_name; [display.colon, name].to_safe_phrase; end
  def clear_name; names.join; end

  def method_missing(meth, *arguments, &block)
    if realm.respond_to?(meth)
      realm.send(meth, *arguments, &block)
    elsif behavior.respond_to?(meth)
      behavior.send(meth, *arguments, &block)
    elsif priority.respond_to?(meth)
      priority.send(meth, *arguments, &block)
    elsif triplet.respond_to?(meth)
      triplet.send(meth, *arguments, &block)
    else
      super
    end
  end

end
