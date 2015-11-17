class Subtype < Phrase

  def initialize(array)
    @realm = array.first
    @attitude = array.second
    super
  end
  attr_reader :realm, :attitude
  delegate :breaks, :accelerator, to: :attitude
  delegate :consume, :produce, :domain, :fat, :thin, :restless, :sore, to: :realm
  def same_realm; ALL.select{|s| s.realm == realm}; end
  def same_attitude; ALL.select{|s| s.attitude == attitude}; end

  def words; [breaks, realm, accelerator]; end
  def to_s; words.join(""); end
  def to_str; words.join(""); end
  def inspect; words.join("").to_word; end
  def name; inspect; end
  def parenthetical; inspect.parenthetical; end

  ALL = Realm::ALL.collect do |realm|
          Attitude::ALL.collect do |attitude|
            self.new [realm,attitude]
          end
        end.flatten
  def sort_order; [breaks, accelerator, realm]; end
  def <=>(other); sort_order <=> other.sort_order; end
  def self.all; ALL.sort; end
  ALL.each{|subtype| define_singleton_method(subtype.to_s) {subtype}}

  def discover_path; Answer.first.next(self); end

  def problem
    case attitude.path
    when "eXp"
      fat
    when "eXj"
      thin
    when "iXp"
      restless
    when "iXj"
      sore
    end
  end
  def solution
    case attitude.path
    when "eXp"
      restless
    when "eXj"
      sore
    when "iXp"
      fat
    when "iXj"
      thin
    end
  end

  def i_am; Phrase.new ["I am", problem, "and", solution]; end
end
