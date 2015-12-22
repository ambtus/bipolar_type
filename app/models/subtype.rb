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

  def generic; Phrase.new [adverb, attitude.generic]; end
  def name; Phrase.new [generic.titleize, inspect.parenthesize]; end
  delegate :ordinal, :strong?, :energetic?, 
    :strong_verb_prefix, :energetic_verb_prefix, 
    :strong_adjective_prefix, :energetic_adjective_prefix, 
    :strong_noun_prefix, :energetic_noun_prefix, 
    to: :attitude

  def method_missing(meth, *arguments, &block)
    realm.respond_to?(meth) ? realm.send(meth, *arguments, &block) : super
  end

end
