class Subtype

  def initialize(behavior, realm, position)
    @behavior = behavior
    @realm = realm
    @position = position
  end
  attr_reader :behavior, :realm, :position

  def triplet; [@behavior, @realm, @position]; end
  def path; triplet.map(&:path).   map(&:chars).flatten.values_at(0,2,1,3).join; end
  def pair; [@behavior, @position]; end
  def display
    if @realm.generic?
      pair.map(&:display).join
    else
      triplet.map(&:display).map(&:chars).flatten.values_at(0,2,1,3).join
    end
  end
  alias inspect :display

  def base_mbti; [@behavior, @realm].map(&:mbti).map(&:chars).flatten.values_at(0,2,1).join; end
  def mbti; [@position.mbti, base_mbti].to_phrase; end

  def <=>(other); pair <=> other.pair; end

  def names;[@position.names.first, @behavior.names.first.ing, @realm.name, @behavior.names.second, @position.names.second]; end
  def name; names.wbr; end
  def symbolic_name; [display.colon, name].to_safe_phrase; end

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

  def inferior?; @position.inferior?; end

  def next; Subtype.select(@behavior.next, @realm, @position.next); end
  def opposite; self.next.next; end
  def previous; opposite.next; end

  def cycle; Cycle.new(*triplet); end
  def sample_behavior;[ @realm.send(@behavior.send_name), @position.adverb].to_phrase; end

end
