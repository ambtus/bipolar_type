class Answer

  def self.first_path; "Q1"; end
  def self.first; Answer.new(first_path); end

  def initialize(string)
    @question,subtype_string = string.split(":")
    @subtype_string = subtype_string || ""
  end
  attr_reader :question

  def number; @question.last.to_i ; end
  def index; number - 1; end
  def finished?; number > 4; end

  def css(subtype)
    return "chosen" if subtypes.include?(subtype)
    return "constrained" if realms.include?(subtype.realm)
    return "constrained" if positions.include?(subtype.position)
    return "free"
  end

  def next(choice); question.next + ":" + @subtype_string + choice.path; end

  def type_path; subtypes.sort_by{|s| s.position.index}.map(&:realm).map(&:path).join; end

  private
  def subtypes; @subtype_string.scan(/.../).collect{|s| Subtype.find(s)}; end
  def realms; subtypes.map(&:realm); end
  def positions; subtypes.map(&:position); end

end
