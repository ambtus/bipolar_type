class Subtype < Phrase

  def initialize(array)
    @realm = array.first
    @attitude = array.second
    super
  end
  attr_reader :realm, :attitude

  def words; attitude.ordered_words(realm); end
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

  def discover_path; Answer.first.next(self); end

  def same_realm; ALL.select{|s| s.realm == realm}; end
  def same_attitude; ALL.select{|s| s.attitude == attitude}; end

  delegate :result, to: :attitude
  delegate :domain, to: :realm

  def result_words; [domain.ly, result]; end
  def result_phrase; Phrase.new result_words; end
  def tagline; Noun.new result_words.map(&:capitalize).join; end
  def name; Phrase.new [tagline, inspect.parenthesize]; end

  def behaviors; attitude.ordered_behaviors(*realm.behaviors); end

end
