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
  def words; [realm, attitude]; end
  def inspect; Word.new words.join("_"); end
  def to_s; inspect.to_s; end
  def to_str; to_s; end

  def path; to_s.underscore; end
  ALL.each{|s| define_singleton_method(s.path) {s}}
  def self.paths; ALL.map(&:path); end

  def discover_path; Answer.first.next(self); end

  def same_realm; ALL.select{|s| s.realm == realm}; end
  def same_attitude; ALL.select{|s| s.attitude == attitude}; end

  def identifier; Phrase.new [realm.identifier.ly, attitude.identifier]; end
  def name; identifier.titleize; end

  def method_missing(meth, *arguments, &block)
    if attitude.respond_to?(meth)
      attitude.send(meth, *arguments, &block)
    elsif realm.respond_to?(meth)
      realm.send(meth, *arguments, &block)
    else
      super
    end
  end

  def behaviors; [produce_energetically, produce_strongly, consume_strengtheners, consume_energizers]; end

  def loved_behavior; behaviors[index]; end
  def hated_behavior; behaviors[(index + 1).modulo(4)]; end
  def disliked_behavior; behaviors[(index + 2).modulo(4)]; end
  def liked_behavior; behaviors[(index + 3).modulo(4)]; end

  def measurable; attitude.index.even? ? realm.strengths : realm.energy; end

  def result; attitude.index < 2 ? measurable.few_phrase : measurable.many_phrase; end

end
