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

  def measurable
    case attitude.identifier.string
    when "strong", "energetic"
      realm.strengths
    when "submissive", "dominant"
      realm.potential
    else
      raise "attitude identifiers changed"
    end
  end

  def result
    case attitude.identifier.string
    when "strong", "submissive"
      measurable.many_phrase
    when "energetic", "dominant"
      measurable.few_phrase
    else
      raise "attitude identifiers changed"
    end
  end

  def goal
    case attitude.identifier.string
    when "strong", "submissive"
      measurable.fewer_phrase
    when "energetic", "dominant"
      measurable.prefix("more ")
    else
      raise "attitude identifiers changed"
    end
  end

  def behaviors; [consume_energizers, produce_energetically, produce_strongly, consume_strengtheners, consume_energizers]; end

  def preface; behaviors[attitude.index]; end
  def behave; behaviors[attitude.index + 1]; end
  def postfix; behaviors[(attitude.index + 3).modulo(4)]; end
  def objects; realm.send %w{pne pns strengtheners energizers }[attitude.index]; end
  def verb; realm.send %w{pve pvs consume_with consume_with }[attitude.index]; end

  def more_behaviors; [produce_more_strongly, consume_more_strengtheners, consume_more_energizers, produce_more_energetically]; end
  def hard; more_behaviors[attitude.index]; end
  def behave_more; more_behaviors[(attitude.index + 3).modulo(4)]; end

  def rare; realm.send(attitude.rare); end
end
