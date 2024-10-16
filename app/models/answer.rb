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

  def taken; answer_string.scan(/.../).collect{|s| Solution.find_by(s)}; end

  def foci; taken.map(&:focus); end
  def free_foci; Focus.all - foci; end
  def states; taken.map(&:state); end

  def taken?(solution); foci.include?(solution.focus) || states.include?(solution.state); end

  def next(string); question.next + ':' + answer_string + string; end

  def last; Solution.all.find{|p| !foci.include?(p.focus) && !states.include?(p.state) }; end

  def all; (taken << last).sort_by(&:state); end

  def type_path; all.map(&:focus).map(&:symbol).join; end

end
