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

  def subtypes; @subtype_string.scan(/.../).collect{|s| Subtype.find(s)}; end
  def realms; subtypes.map(&:realm); end
  def problems; subtypes.map(&:problem); end

  def css(subtype)
    return 'chosen' if subtypes.include?(subtype)
    return 'constrained' if realms.include?(subtype.realm)
    return 'constrained' if problems.include?(subtype.problem)
    return 'free'
  end

  def free_realm?(realm); true unless realms.include?(realm); end
  def free_problem?(problem); true unless problems.include?(problem); end

  def taken?(subtype); true unless css(subtype) == 'free'; end

  def next(choice); question.next + ':' + @subtype_string + choice.path; end
  def resort; by_state ?  path.delete('+by_state')  : path + '+by_state'; end


  def last_subtype; (Realm.all - realms).first + (Problem.all - problems).first; end

  def type_path; (subtypes + [last_subtype]).sort_by{|s| s.problem.index}.map(&:realm).map(&:symbol).join + last_subtype.realm.symbol; end


end
