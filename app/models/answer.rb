class Answer

  def self.first_path; "Q1"; end
  def self.first; Answer.new(first_path); end

  def initialize(string)
    @question,attitudes = string.split(":")
    @attitude_paths = attitudes || ""
  end
  attr_reader :question, :attitude_paths

  def number; @question.last.to_i ; end
  def index; number - 1; end
  def realm; Realm.all[index]; end
  def finished?; number > 4; end

  def next(new); "#{question.next}:#{attitude_paths}#{new}"; end

  def type_path; attitude_paths.scan(/./).join("-"); end

end
