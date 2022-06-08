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
    return "constrained" if positions.include?(choice.first)
    return "constrained" if realms.include?(choice.second)
    return "free"
  end

  def next(choice); question.next + ":" + @subtype_string + choice; end

  ARROWS = Realm::ARROWS.map(&:first)
  def type_path; subtypes.sort_by{|s| ARROWS.index(s.second) }.map(&:first).join; end

  private
  def subtypes; @subtype_string.scan(/../); end
  def realms; subtypes.map(&:second); end
  def positions; subtypes.map(&:first); end

end
