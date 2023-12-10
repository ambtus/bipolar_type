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
    return "constrained" if realms.include?(choice.realm)
    return "constrained" if phases.include?(choice.phase)
    return "free"
  end

  def next(choice); question.next + ":" + @subtype_string + choice.symbol; end

  def type_path; subtypes.sort.map(&:realm).map(&:symbol).join; end

  private
  def subtypes; @subtype_string.scan(/../).collect{|s| Behavior.send(s)}; end
  def realms; subtypes.map(&:realm); end
  def phases; subtypes.map(&:phase); end

end
