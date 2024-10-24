class Answer

  def self.first_path; 'Q1'; end
  def self.first; Answer.new(first_path); end

  def initialize(string)
    @path = string
    @question,answer_string = @path.split(':')
    @answer_string = answer_string || ''
  end
  attr_reader :question, :path, :answer_string

  def number; @question.last ; end
  def finished?; number.to_i > 3; end

  def taken; answer_string.scan(/.../).collect{|s| Subtype.find_by(s)}; end

  def things; taken.map(&:thing); end
  def tendencies; taken.map(&:tendency); end

  def taken?(subtype); things.include?(subtype.thing) || tendencies.include?(subtype.tendency); end

  def next(string); question.next + ':' + answer_string + string; end

  def last; Subtype.all.find{|s| !things.include?(s.thing) && !tendencies.include?(s.tendency) }; end

  def all; (taken << last).sort_by(&:help); end

  def thing_string; all.map(&:thing).map(&:symbol).join; end
  def type_path; Type.find_by_thing_string(thing_string).path; end
end
