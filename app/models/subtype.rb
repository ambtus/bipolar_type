class Subtype < Phrase

  def initialize(array)
    @realm = array.first
    @attitude = array.second
    super
  end
  attr_reader :realm, :attitude

  def words; attitude.subtype_words(realm); end
  def to_s; words.join(""); end
  def to_str; words.join(""); end
  def path; to_s.downcase; end
  def inspect; words.join("").to_word; end

  def sort_order; [attitude, realm]; end
  def <=>(other); sort_order <=> other.sort_order; end

  ALL = Attitude::ALL.collect do |attitude|
          Realm::ALL.collect do |realm|
            self.new [realm,attitude]
          end
        end.flatten
  def self.all; ALL; end
  ALL.each{|subtype| define_singleton_method(subtype.path) {subtype}}
  def self.paths; ALL.map(&:path); end

  def discover_path; Answer.first.next(self); end

  def same_realm; ALL.select{|s| s.realm == realm}; end
  def same_attitude; ALL.select{|s| s.attitude == attitude}; end

  def domains; [realm.domain.ly, attitude.domain]; end
  def domain; Phrase.new domains.map(&:capitalize) ; end
  def name; Phrase.new [domain, inspect.parenthesize]; end

  def short; attitude.short(realm); end

end
