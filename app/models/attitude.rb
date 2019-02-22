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

  PROBLEMS = %w{greedy lazy fussy hyperactive}
  def self.problems; PROBLEMS; end

  def problem; PROBLEMS[index]; end
  def name; problem.capitalize; end

  PROBLEMS.each do |problem|
    define_singleton_method(problem.first) {ALL[PROBLEMS.index(problem)]}
  end

  def manic?; %w{hyperactive fussy}.include?(problem); end
  def goals?; %w{hyperactive lazy}.include?(problem); end
  def compulsive?; %w{hyperactive greedy}.include?(problem); end

  def episode; manic? ? "manic" : "depressed"; end

  def imbalance; manic? ? "deficit" : "surplus"; end

  def drugs; manic? ? "sedatives" : "stimulants"; end

  def verb; goals? ? "achieve" : "harvest"; end
  def differently; compulsive? ? "less" : "more"; end
  def solution; [verb, differently].join(" "); end

  def nouns; goals? ? "goals" : "resources"; end
  def different; compulsive? ? "fewer" : "more"; end

  def opposite; ALL.find{|x| x.manic? == self.manic? && x != self}; end

  def episode_trigger; opposite.solution.ed; end
  def result; %w{exhausted lethargic restless overstimulated}[index]; end
end
