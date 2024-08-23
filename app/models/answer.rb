class Answer

  def self.first_path; 'Q1'; end
  def self.first; Answer.new(first_path); end

  def initialize(string)
    @path = string
    @question,subtype_string = @path.split(':')
    @subtype_string = subtype_string || ''
  end
  attr_reader :question, :path, :subtype_string

  def number; @question.last.to_i ; end
  def index; number - 1; end
  def finished?; number > 3; end

  def subtypes; @subtype_string.scan(/..../).collect{|s| Subtype.find(s)}; end
  def realms; subtypes.map(&:realm); end
  def behaviors; subtypes.map(&:behavior); end
  def priorities; subtypes.map(&:priority); end

  def free_realms; Realm.all.without(realms); end


  def taken_subtypes; subtypes.map(&:cycle).map(&:subtypes).flatten; end

  def taken_compulsions; taken_subtypes.select{|s| s.priority.last?}.sort; end

  def taken_pairs; taken_subtypes.collect{|s| [s.behavior, s.priority]}; end

  def css(subtype)
    return 'chosen' if subtypes.include?(subtype)
    return 'constrained' if taken_pairs.include? [subtype.behavior, subtype.priority]
    return 'constrained' unless free_realms.include?(subtype.realm)
    return 'free'
  end
  def taken?(subtype); true unless css(subtype) == 'free'; end

  def next(choice); question.next + ':' + @subtype_string + choice.path; end

  def last_realm; Realm.all.without(taken_compulsions.map(&:realm)).first; end
  def last_behavior; Behavior.all.without(taken_compulsions.map(&:behavior)).first; end
  def last_compulsion; Subtype.find([last_behavior,last_realm,Priority.last]); end
  def all_compulsions; taken_compulsions.push(last_compulsion).sort_by{|s| s.behavior}; end
  def type_path;all_compulsions.map(&:realm).map(&:path).join; end

end
