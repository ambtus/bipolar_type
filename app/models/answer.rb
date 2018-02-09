class Answer

  def self.first_path; "Q1"; end
  def self.first; Answer.new(first_path); end

  def initialize(string)
    @question,states = string.split(":")
    @state_paths = states || ""
  end
  attr_reader :question, :state_paths

  def number; @question.last.to_i ; end
  def index; number - 1; end
  def energy; Energy.all[index]; end
  def finished?; number > 4; end

  def next(new); "#{question.next}:#{state_paths}#{new}"; end

  def type_path; state_paths; end

end
