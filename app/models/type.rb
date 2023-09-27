class Type

  def self.my_path; "FMAP"; end
  def self.my_type; self.new my_path; end

  def initialize(string)
    @symbol = string
    @realms = string.scan(/./).collect{|x| Realm.send(x)}
    @realms.check_constraints Realm, 4, 4
  end
  attr_reader :symbol, :realms

  ALL = Realm::SYMBOLS.permutation(4).collect{|x| new(x.join)}

  def behaviors; realms.add(GenericBehavior.all); end

  def best_at; realms.values_at(2,3,0,1).add(GenericBehavior.all); end

  def name; realms.map(&:symbol).join; end
  def inspect; @symbol; end

  def index(behavior); behaviors.index(behavior); end

  def next_behavior(behavior); behaviors[index(behavior)+1] || behaviors.first; end
  def previous_behavior(behavior); behaviors[index(behavior)-1] || behaviors.last; end
  def opposite_behavior(behavior); next_behavior(next_behavior(behavior)); end

end
