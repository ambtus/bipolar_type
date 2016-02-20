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

  def path; to_s; end
  ALL.each{|s| define_singleton_method(s.path) {s}}
  def self.paths; ALL.map(&:path); end

  def peers; ALL.select{|s| s.realm == realm || s.attitude == attitude}; end
  def discover_path; Answer.first.next(self); end

  def same_realm; ALL.select{|s| s.realm == realm}; end
  def opposite; same_realm.find{|s| s.attitude == attitude.opposite}; end
  def manic; same_realm.find{|s| s.attitude == attitude.manic}; end
  def depressed; same_realm.find{|s| s.attitude == attitude.depressed}; end

  def identifier; Phrase.new [realm, attitude].map(&:identifier); end
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

  def preference; more? ? "like to" : "don’t like to"; end
  def behavior; rational? ? produce : consume; end

  def short; "I #{preference} #{behavior}"; end

  def advice
    case ordinal
    when "first"
      Phrase.new [consume, "more"]
    when "second"
      Phrase.new [consume, "less so I will", produce, "less"]
    when "third"
      Phrase.new [consume, "more so I will", produce, "more"]
    when "fourth"
      Phrase.new [consume, "less"]
    end
  end

end
