class Answer

  def self.first_path; 'Q1'; end
  def self.first; Answer.new(first_path); end

  def initialize(string)
    @question,subtype_string = string.split(':')
    @subtype_string = subtype_string || ''
  end
  attr_reader :question

  def number; @question.last.to_i ; end
  def index; number - 1; end
  def finished?; number > 4; end

  def css(subtype)
    return 'chosen' if subtypes.include?(subtype)
    return 'constrained' if realms.include?(subtype.realm)
    return 'constrained' if problems.include?(subtype.problem)
    return 'free'
  end

  def free?(subtype); css(subtype) == 'free'; end

  def next(subtype); question.next + ':' + @subtype_string + subtype.symbol; end

  def type_path; subtypes.sort.map(&:realm).map(&:symbol).join; end

  private
  def subtypes; @subtype_string.scan(/.../).collect{|s| Subtype.send(s)}; end
  def realms; subtypes.map(&:realm); end
  def problems; subtypes.map(&:problem); end

end
