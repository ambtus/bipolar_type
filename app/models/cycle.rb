class Cycle

  def initialize(triplet); @triplet = triplet; end
  attr_reader :triplet
  def last; Subtype.find([@triplet, Priority.last]); end
  def path; last.path; end
  def display; last.display + ' cycle'; end
  alias inspect :display
  def type; 'cycle' + last.behavior.path.last; end

  ALL = Triplet.all.collect {|triplet| Cycle.new(triplet)}

  class << self
    def find(thing)
      subtype = thing.is_a?(String) ? Subtype.send(thing) : thing
      ALL.find{|c| c.subtypes.include?(subtype)}
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

  def subtypes; [last, last.flip, last.flop, last.opposite]; end
  def by_quarter; subtypes.sort_by {|s| s.behavior.index}; end
  def by_focus; subtypes.sort_by {|s| s.priority.index}; end
end
