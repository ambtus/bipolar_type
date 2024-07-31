class Cycle

  def initialize(behavior, realm, position)
    @realm = realm
    @behavior = behavior
    @position = position
  end
  attr_reader :behavior, :realm, :position

  def first_subtype; Subtype.select(@behavior, @realm, @position); end
  def path; first_subtype.path; end
  def display; first_subtype.display; end
  alias inspect :display

  ALL = Behavior.all.collect do |behavior|
          Realm::ALL.collect do |realm|
            Position.all.collect do |position|
              self.new(behavior,realm,position)
            end
          end
        end.flatten

  class << self
    def find(string); ALL.find{|s| s.path == string}; end
    def select( behavior, realm, position); ALL.find{|s| s.realm == realm && s.behavior == behavior && s.position == position}; end
    def all; ALL; end
    def each(&block); ALL.each(&block); end
  end

  ALL.each_with_index do |instance, index|
    %w{path}.each do |thing|
      define_singleton_method(instance.send(thing)) {ALL[index]}
      define_singleton_method(instance.send(thing).downcase) {ALL[index]}
    end
  end

  def subtypes; [first_subtype, first_subtype.next, first_subtype.opposite, first_subtype.previous]; end
end
