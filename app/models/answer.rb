class Answer

  def self.first_path; "Q1"; end
  def self.first; Answer.new(first_path); end

  def initialize(string)
    @question,@solution_paths = string.split(":")
    @solution_paths = @solution_paths || ""
  end
  attr_reader :question, :solution_paths

  def number; @question.last.to_i ; end
  def index; number - 1; end
  def finished?; number > 4; end

  def solutions; @solution_paths.scan(/.../).collect{|s| Solution.send(s)}.sort; end

  def realm_taken?(realm); solutions.map(&:realm).include?(realm); end
  def generic_taken?(generic); solutions.map(&:generic_solution).include?(generic); end
  def taken?(solution); realm_taken?(solution.realm) || generic_taken?(solution.generic_solution); end


  def paths(solution); [solution_paths, solution.symbol].join; end
  def next(solution); "#{question.next}:#{paths(solution)}"; end

  def type_path; solutions.map(&:realm).map(&:symbol).join; end


end
