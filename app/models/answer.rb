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

  def taken; answer_string.scan(/.../).collect{|s| Behavior.find_by(s)}; end

  def foci; taken.map(&:focus); end
  def states; taken.map(&:state); end

  def taken?(behavior); foci.include?(behavior.focus) || states.include?(behavior.state); end

  def next(string); question.next + ':' + answer_string + string; end

  def last; Behavior.all.find{|p| !foci.include?(p.focus) && !states.include?(p.state) }; end

  def all; (taken << last).sort; end

  def quad_path; all.map(&:focus).map(&:symbol).join; end

end
