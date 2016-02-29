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

  def identifier; Phrase.new [adjective, attitude.identifier]; end
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

  def issue_behavior
    case ordinal
    when "first"
      "#{consume_with} too #{triggers.many_phrase}"
    when "second"
      "#{produce} too much"
    when "third"
      "don’t #{consume_with} enough #{triggers}"
    when "fourth"
      "don’t #{produce} enough"
    end
  end
  def issue_state; diagonal? ? "depressed" : "manic"; end
  def issue
    "I #{issue_behavior} when I am #{issue_state}"
  end

  def preference_behavior; top? ? consume : produce; end
  def preference_modifier; "don’t" unless diagonal?; end
  def preference
    "I #{preference_modifier} like to #{preference_behavior}".squish
  end

  def have_potential; potential.send (attitude.have + "_phrase"); end
  def have
    "I have #{have_potential} than average"
  end

  def want_potential; potential.send (attitude.want + "_phrase"); end
  def want_behavior; top? ? consume : produce; end
  def want_modifier; diagonal? ? "more" : "less"; end
  def want
    "If I had #{want_potential} I could #{want_behavior} #{want_modifier}"
  end

end
