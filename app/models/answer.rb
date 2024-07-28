class Answer

  def self.first_path; 'Q1'; end
  def self.first; Answer.new(first_path); end

  def initialize(string)
    @path, @by_state = string.split('+')
    @question,subtype_string = @path.split(':')
    @subtype_string = subtype_string || ''
  end
  attr_reader :question, :path, :by_state

  def number; @question.last.to_i ; end
  def index; number - 1; end
  def finished?; number > 3; end

  def realm; (Realm.all - realms).sample; end

  def subtypes; @subtype_string.scan(/../).collect{|s| Subtype.find(s)}; end
  def realms; subtypes.map(&:realm); end
  def behaviors; subtypes.map(&:behavior); end

  def css(subtype)
    return 'chosen' if subtypes.include?(subtype)
    return 'constrained' if realms.include?(subtype.realm)
    return 'constrained' if behaviors.include?(subtype.behavior)
    return 'free'
  end

  def free_realm?(realm); true unless realms.include?(realm); end
  def free_behavior?(behavior); true unless behaviors.include?(behavior); end

  def taken?(subtype); true unless css(subtype) == 'free'; end

  def next(choice); question.next + ':' + @subtype_string + choice.path; end
  def resort; by_state ?  path.delete('+by_state')  : path + '+by_state'; end


  def last_subtype; (Realm.all - realms).first + (Behavior.all - behaviors).first; end

  def type_path; subtypes.push(last_subtype).sort_by{|s| s.behavior.index}.map(&:realm).map(&:symbol).join; end


end
