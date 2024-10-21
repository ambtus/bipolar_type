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

  def taken; answer_string.chars.collect{|s| Thing.find_by(s)}; end

  def free_things; Thing.all - taken; end

  def pair; [free_things, free_things.reverse]; end

  def next(string); question.next + ':' + answer_string + string; end


  def type_path; answer_string.chars.values_at(0,2,3,1).join; end
end
