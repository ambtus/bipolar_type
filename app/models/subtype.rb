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
  def word; Word.new realm.letter + attitude.suffix; end
  def inspect; word; end
  def to_s; word.to_s; end
  def path; words.join.downcase; end
  ALL.each{|subtype| define_singleton_method(subtype.path) {subtype}}
  def self.paths; ALL.map(&:path); end

  def discover_path; Answer.first.next(self); end

  def same_realm; ALL.select{|s| s.realm == realm}; end
  def same_attitude; ALL.select{|s| s.attitude == attitude}; end

  def adverb; realm.adjective.ly; end
  def adjectives; [adverb, attitude.adjective]; end
  def name; Phrase.new [adjectives.map(&:capitalize), inspect.parenthesize]; end

  delegate :ordinal, to: :attitude

  def method_missing(meth, *arguments, &block)
    realm.respond_to?(meth) ? realm.send(meth, *arguments, &block) : super
  end

end
