class Cycle

  def initialize(triplet); @triplet = triplet; end
  attr_reader :triplet
  def distress; Subtype.find([@triplet, State.distress]); end
  def path; distress.path; end
  def display; distress.display + ' cycle'; end
  alias inspect :display

  ALL = Triplet.all.collect {|triplet| Cycle.new(triplet)}

  class << self
    def find_with(thing)
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

  def subtypes; [distress, distress.guilt, distress.eustress, distress.happy]; end
end
