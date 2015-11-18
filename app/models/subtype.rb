class Subtype < Phrase

  def initialize(array)
    @realm = array.first
    @attitude = array.second
    super
  end
  attr_reader :realm, :attitude
  delegate :preference, :order, to: :attitude

  def same_realm; ALL.select{|s| s.realm == realm}; end
  def same_attitude; ALL.select{|s| s.attitude == attitude}; end

  def words; [preference, realm, order]; end
  def to_s; words.join(""); end
  def to_str; words.join(""); end
  def inspect; words.join("").to_word; end
  def name; inspect; end
  def parenthetical; inspect.parenthetical; end

  def sort_order; [attitude, realm]; end
  def <=>(other); sort_order <=> other.sort_order; end

  ALL = Attitude::ALL.collect do |attitude|
          Realm::ALL.collect do |realm|
            self.new [realm,attitude]
          end
        end.flatten
  def self.all; ALL; end
  ALL.each{|subtype| define_singleton_method(subtype.to_s) {subtype}}

  def discover_path; Answer.first.next(self); end

  delegate :domain, :binge, :graze, :putz, :outburst, :thin, :fat, to: :realm
  delegate :happy_time, to: :preference

  def schedule; order.schedule(realm); end

  def behaviors; order.behaviors(realm); end
  def dominant; behaviors[preference.other.index]; end
  def auxiliary; behaviors[preference.index]; end

end
