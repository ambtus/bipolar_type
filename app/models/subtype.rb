class Subtype < Phrase

  def initialize(array)
    @realm = array.first
    @attitude = array.second
    super
  end
  attr_reader :realm, :attitude

  ALL = Attitude::ALL.collect do |attitude|
          Realm::ALL.collect do |realm|
            self.new [realm,attitude]
          end
        end.flatten
  def self.all; ALL; end
  def words; [attitude.first, realm, attitude.second]; end
  def inspect; Word.new words.join.upcase; end
  def to_s; inspect.to_s; end
  def to_str; to_s; end
  def name; inspect; end

  def <=>(other); attitude.index <=> other.attitude.index; end

  def path; words.join.to_s; end
  ALL.each{|s| define_singleton_method(s.path) {s}}
  def self.paths; ALL.map(&:path); end

  def peers; ALL.select{|s| s.realm == realm || s.attitude == attitude} - [self]; end
  def discover_path; Answer.first.next(self); end

  def same_realm; ALL.select{|s| s.realm == realm}; end
  def same_attitude; ALL.select{|s| s.attitude == attitude}; end

  def opposite; ALL.find{|s| s.realm == realm && s.attitude == attitude.opposite}; end

  def method_missing(meth, *arguments, &block)
    if attitude.respond_to?(meth)
      attitude.send(meth, *arguments, &block)
    elsif realm.respond_to?(meth)
      realm.send(meth, *arguments, &block)
    else
      super
    end
  end

  def description; Phrase.new [description_adjective, adjective, description_noun]; end
  def name; description.titleize; end

end
