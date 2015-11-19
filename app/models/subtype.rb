class Subtype < Phrase

  def initialize(array)
    @realm = array.first
    @attitude = array.second
    super
  end
  attr_reader :realm, :attitude
  delegate :sensitivity, :order, to: :attitude

  def same_realm; ALL.select{|s| s.realm == realm}; end
  def same_attitude; ALL.select{|s| s.attitude == attitude}; end

  def words; [sensitivity, realm, order]; end
  def to_s; words.join(""); end
  def to_str; words.join(""); end
  def inspect; words.join("").to_word; end
  def name; inspect; end
  def parenthesize; inspect.parenthesize; end


  def sort_order; [attitude, realm]; end
  def <=>(other); sort_order <=> other.sort_order; end

  ALL = Attitude::ALL.collect do |attitude|
          Realm::ALL.collect do |realm|
            self.new [realm,attitude]
          end
        end.flatten
  def self.all; ALL; end
  def path; [sensitivity.path, realm, order].join; end
  ALL.each{|subtype| define_singleton_method(subtype.path) {subtype}}

  def discover_path; Answer.first.next(self); end

  delegate :domain, :binge, :graze, :putz, :burst, to: :realm
  delegate :frequency, to: :sensitivity

  def schedule; order.schedule(realm); end
  def result; attitude.result(realm); end

  def liked_behaviors; sensitivity.priority(order.behaviors(realm)); end
  def disliked_behaviors; sensitivity.other.priority(order.other.behaviors(realm)); end
  def behaviors; liked_behaviors + disliked_behaviors; end

  def dominant; behaviors.first; end
  def behave_more
    dominant.is_a?(Word) ? Phrase.new([dominant, "more"]) : Phrase.new([dominant.words.first, "more", dominant.words.last])
  end
end
