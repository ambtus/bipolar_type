class Cycle

  def initialize(subtype); @subtype = subtype; end
  attr_reader :subtype
  def path; subtype.path; end
  def display; subtype.display + ' cycle'; end
  alias inspect :display

  def behavior; subtype.behavior; end
  def realm; subtype.realm; end
  def state; subtype.state; end

  ALL = Subtype.all.collect {|subtype| Cycle.new(subtype)}

  class << self
    def find(thing)
      if thing.is_a? String
        self.send(thing)
      elsif thing.is_a? Subtype
        self.send(thing.path)
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

  def subtypes; [subtype, subtype.next, subtype.opposite, subtype.previous]; end
end
