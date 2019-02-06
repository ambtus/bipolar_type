class Attitude < Concept

  ########
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  PATHS.each do |path|
    define_singleton_method(path) {ALL[PATHS.index(path)]}
  end
  %w{first second third fourth}.each_with_index do |ordinal, index|
    define_singleton_method(ordinal) {ALL[index]}
  end
  ########

  def subtypes; Subtype.all.select{|s| s.attitude == self}; end
  def +(realm); subtypes.find{|s| s.realm == realm}; end

  PROBLEMS = %w{hyperactive finicky lazy greedy}
  def problem; PROBLEMS[index]; end
  def name; problem.capitalize; end

  PROBLEMS.each do |problem|
    define_singleton_method(problem.first) {ALL[PROBLEMS.index(problem)]}
  end

  def high_energy?; %w{greedy hyperactive}.include?(problem); end
  def conservative?; %w{greedy lazy}.include?(problem); end
  def goal_oriented?; %w{hyperactive lazy}.include?(problem); end

end
