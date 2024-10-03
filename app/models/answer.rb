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

  def selected; answer_string.chars.collect{|c| Function.send(c)}; end
  def functions; Function.all - selected; end
  def pair; [functions, functions.reverse]; end


  def next(string); question.next + ':' + answer_string + string; end


end
