class Triplet

  def initialize(behavior, realm)
    @behavior = behavior
    @realm = realm
  end
  attr_reader :behavior, :realm

  def pair; [@behavior, @realm]; end
  def path; pair.map(&:path).map(&:chars).flatten.values_at(0,2,1).join; end
  alias mbti :path
  def display
    if @realm.generic?
      behavior.display
    else
      pair.map(&:display).map(&:chars).flatten.values_at(0,2,1).join
    end
  end
  alias inspect :display

  def <=>(other); behavior <=> other.behavior; end

  ALL = Behavior.all.collect do |behavior|
          Realm::ALL.collect do |realm|
            self.new(behavior,realm)
          end
        end.flatten

  class << self
    def find(thing)
      if thing.is_a? String
        self.send(thing)
      elsif thing.is_a? Array
        ALL.find{|s| s.behavior == thing.first &&  s.realm == thing.second}
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

  def next; Triplet.find([@behavior.next, @realm]); end
  def opposite; self.next.next; end
  def previous; opposite.next; end

  # use adjective.capitalize instead of name to get '' for Generic
  def names;[@behavior.verb, @realm.adjective.capitalize, @behavior.noun]; end
  def name; names.wbr; end
  def symbolic_name; [display.colon, name].to_safe_phrase; end
  def phrase; names.to_phrase; end

  def examples;@realm.send(@behavior.send_name); end
  def eg; examples.split('.').first; end

end
