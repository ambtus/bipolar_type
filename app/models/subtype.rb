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
  def inspect; Word.new words.join; end
  def to_s; inspect.to_s; end
  def to_str; to_s; end
  def path; to_s.downcase; end

  ALL.each{|s| define_singleton_method(s.path) {s}}
  def self.paths; ALL.map(&:path); end

  def discover_path; Answer.first.next(self); end

  def same_realm; ALL.select{|s| s.realm == realm}; end
  def same_attitude; ALL.select{|s| s.attitude == attitude}; end

  def domain; Phrase.new [realm.domain, attitude.domain]; end
  def name; Phrase.new [realm.name, attitude.name]; end

  def method_missing(meth, *arguments, &block)
    if attitude.respond_to?(meth)
      attitude.send(meth, *arguments, &block)
    elsif realm.respond_to?(meth)
      realm.send(meth, *arguments, &block)
    else
      super
    end
  end

  def result
    case attitude.domain.string
    when "bulkiness"
      realm.strengths.many_phrase
    when "obesity"
      realm.potential.many_phrase
    when "anorexia"
      realm.potential.few_phrase
    when "weakness"
      realm.strengths.few_phrase
    end
  end

  %w{morning_feeling morning_behavior afternoon_feeling afternoon_behavior evening_feeling_adjective evening_behavior night_feeling_adjective night_noun}.each do |meth|
    define_method(meth) {realm.send(attitude.send(meth).to_s.gsub(" ", "_"))}
  end

  def evening_feeling; Phrase.optional evening_feeling_prefix, evening_feeling_adjective; end
  def night_feeling; Phrase.optional night_feeling_prefix, night_feeling_adjective; end
  def night_behavior; Phrase.new [night_verb, night_noun]; end

  def morning_do
    case attitude.domain.string
    when "bulkiness", "weakness"
      consume_triggers
    when "obesity", "anorexia"
      produce_strongly
    end
  end
  def morning_dont
    case attitude.domain.string
    when "bulkiness", "weakness"
      produce_strongly
    when "obesity", "anorexia"
      consume_triggers
    end
  end


  def evening_do
    case attitude.domain.string
    when "bulkiness", "weakness"
      produce_strongly
    when "obesity", "anorexia"
      consume_triggers
    end
  end
def evening_dont
    case attitude.domain.string
    when "bulkiness", "weakness"
      consume_triggers
    when "obesity", "anorexia"
      produce_strongly
    end
  end

end
