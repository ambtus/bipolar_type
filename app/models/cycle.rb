class Cycle

  def initialize(triplet); @triplet = triplet; end
  attr_reader :triplet
  def compulsion; Subtype.find([@triplet, State.compulsion]); end
  def path; compulsion.path; end
  def display; compulsion.display + ' cycle'; end
  alias inspect :display
  def type; compulsion.behavior.mbti.downcase; end

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

  def subtypes; [compulsion, compulsion.flip, compulsion.flop, compulsion.opposite]; end
  def by_quarter; subtypes.sort_by {|s| s.behavior.index}; end
  def by_focus; subtypes.sort_by {|s| s.state.index}; end
end
