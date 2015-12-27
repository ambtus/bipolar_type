class Subtype < Phrase

  def initialize(array)
    @realm = array.first
    @attitude = array.second
    super
  end
  attr_reader :realm, :attitude

  def sort_order; [attitude, realm]; end
  def <=>(other); sort_order <=> other.sort_order; end

  ALL = Attitude::ALL.collect do |attitude|
          Realm::ALL.collect do |realm|
            self.new [realm,attitude]
          end
        end.flatten
  def self.all; ALL; end
  def words; [attitude.first, realm, attitude.second]; end
  def inspect; Word.new words.join; end
  def to_s; inspect.to_s; end
  def to_str; to_s; end
  def path; to_s.downcase; end

  ALL.each{|s| define_singleton_method(s.path) {s}}
  def self.paths; ALL.map(&:path); end

  def discover_path; Answer.first.next(self); end

  def same_realm; ALL.select{|s| s.realm == realm}; end
  def same_attitude; ALL.select{|s| s.attitude == attitude}; end

  def domain; Phrase.new [domainly, attitude.domain]; end
  def name; Phrase.new [domain.titleize.join, inspect.parenthesize]; end

  def wannabee; Subtype.new [realm, attitude.wannabee]; end
def goal; Subtype.new [realm, attitude.goal]; end

  def method_missing(meth, *arguments, &block)
    if attitude.respond_to?(meth)
      attitude.send(meth, *arguments, &block)
    elsif realm.respond_to?(meth)
      realm.send(meth, *arguments, &block)
    else
      super
    end
  end

end
