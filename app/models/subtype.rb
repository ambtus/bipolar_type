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

  def modifier; left? ? "more" : energy.fewer; end
  def behavior; backslash? ? use : consume; end

  def short; "I #{behavior} #{modifier} #{energy} than my peers do"; end

  def ease
    "It’s easier for me to #{easy} #{potential} than to #{hard} #{potential.them}"
  end

  def safe_verb; backslash? ? consume : use; end
  def safe_object; left? ? energy.many_phrase : energy.few_phrase; end

  def unsafe_verb; backslash? ? use : consume; end
  def unsafe_object; left? ? energy.fewer_phrase : energy.more_phrase; end
  def unsafe; Phrase.new [unsafe_verb, unsafe_object]; end

  def advice; Phrase.new [safe_verb.capitalize, "as", safe_object, "as you can and don’t try to", unsafe]; end

end
