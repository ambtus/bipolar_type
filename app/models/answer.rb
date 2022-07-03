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

  def css(choice)
    return "chosen" if subtypes.include?(choice)
    return "constrained" if realms.include?(choice.first)
    return "constrained" if positions.include?(choice.chars.second)
    return "free"
  end

  def next(choice); question.next + ":" + @subtype_string + choice; end

  def type_path; subtypes.sort_by{|s| ARROWS.index(s.chars.second) }.map(&:first).join; end

  private
  def subtypes; @subtype_string.scan(/../); end
  def realms; subtypes.map(&:first); end
  def positions; subtypes.map(&:chars).map(&:second); end

end
