class Answer

  def self.first_path; 'Q1'; end
  def self.first; Answer.new(first_path); end

  def initialize(string)
    @path = string
    @question,subtype_string = @path.split(':')
    @subtype_string = subtype_string || ''
  end
  attr_reader :question, :path, :subtype_string
  def subtypes; @subtype_string.scan(/..../).collect{|s| Subtype.find(s)}; end

  def number; @question.last.to_i ; end
  def index; number - 1; end
  def finished?; number > 3; end

  def realms; subtypes.map(&:realm); end
  def behaviors; subtypes.map(&:behavior); end
  def positions; subtypes.map(&:position); end

  def taken_subtypes; subtypes.map(&:cycle).map(&:subtypes).flatten; end
  def taken_dominants; taken_subtypes.select{|s| s.position.dominant?}.sort; end

  def taken_pairs; taken_subtypes.collect{|s| [s.behavior, s.position]}; end

  def css(subtype)
    return 'chosen' if subtypes.include?(subtype)
    return 'constrained' if taken_subtypes.include?(subtype)
    return 'constrained' if taken_pairs.include? [subtype.behavior, subtype.position]
    return 'free'
  end

  def taken?(subtype); true unless css(subtype) == 'free'; end

  def next(choice); question.next + ':' + @subtype_string + choice.path; end

  def last_realm; Realm.all.without(taken_dominants.map(&:realm)).first; end
  def last_behavior; Behavior.all.without(taken_dominants.map(&:behavior)).first; end
  def last_dominant; Subtype.select(last_behavior,last_realm,Position.dominant); end
  def all_dominants; taken_dominants.push(last_dominant).sort; end
  def type_path;all_dominants.map(&:realm).map(&:path).join; end

end
