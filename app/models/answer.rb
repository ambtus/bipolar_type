class Answer

  def self.first_path; 'Q1'; end
  def self.first; Answer.new(first_path); end

  def initialize(string)
    @path, @with = string.split('+')
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
  def states; subtypes.map(&:state); end

  def free_realms; Realm.all.without(realms); end
  def realm; @with ? Realm.send(@with.last) : free_realms.first; end


  def taken_subtypes; subtypes.map(&:cycle).map(&:subtypes).flatten; end
  def taken_eustresses; taken_subtypes.select{|s| s.state.eustress?}.sort; end

  def taken_pairs; taken_subtypes.collect{|s| [s.behavior, s.state]}; end

  def css(subtype)
    return 'chosen' if subtypes.include?(subtype)
    return 'constrained' if taken_pairs.include? [subtype.behavior, subtype.state]
    return 'free'
  end
  def taken?(subtype); true unless css(subtype) == 'free'; end

  def next(choice); question.next + ':' + @subtype_string + choice.path; end
  def try(realm); question + ':' + @subtype_string + '+with_' + realm.mbti; end

  def last_realm; Realm.all.without(taken_eustresses.map(&:realm)).first; end
  def last_behavior; Behavior.all.without(taken_eustresses.map(&:behavior)).first; end
  def last_eustress; Subtype.find([last_behavior,last_realm,State.eustress]); end
  def all_eustresses; taken_eustresses.push(last_eustress).sort; end
  def type_path;all_eustresses.map(&:realm).map(&:path).join; end

end
