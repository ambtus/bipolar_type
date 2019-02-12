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

  PROBLEMS = %w{ fussy greedy hyperactive  lazy  }
  def self.problems; PROBLEMS; end

  def problem; PROBLEMS[index]; end
  def name; problem.capitalize; end

  PROBLEMS.each do |problem|
    define_singleton_method(problem.first) {ALL[PROBLEMS.index(problem)]}
  end

  def goals?; %w{hyperactive lazy}.include?(problem); end
  def manic?; %w{fussy hyperactive}.include?(problem); end
  def compulsive?; %w{greedy hyperactive}.include?(problem); end

  def orientation; goals? ? "goals" : "resources"; end
  def episode; manic? ? "mania" : "depression"; end
  def direction; compulsive? ? "compulsion" : "aversion"; end

  def opposite; ALL.find{|x| x.orientation == self.orientation && x != self}; end
  def envies; opposite.name; end
end
