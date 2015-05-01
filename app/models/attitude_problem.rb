class AttitudeProblem
  LETTERS = Attitude.all.collect{|a| a.problem_letters.collect{|pl| a.letter + pl}}.flatten

  def initialize(string)
    raise "#{string} isn't an AttitudeProblem" unless LETTERS.include?(string)
    @index = LETTERS.index(string)
    @letters = string
    @attitude_letter = string[0]
    @problem_letter = string[1]
  end
  attr_reader :letters, :attitude_letter, :problem_letter

  ATTITUDE_PROBLEMS = LETTERS.collect{|choice| AttitudeProblem.new(choice)}
  def self.all; ATTITUDE_PROBLEMS; end

  def self.find(letters); ATTITUDE_PROBLEMS[LETTERS.index(letters)]; end

  def attitude; Attitude.find(attitude_letter); end
  def problem; Attitude.find(problem_letter); end
  def solution; problem.opposite; end

  def mbti; letters.capitalize.mbti_order; end

  def +(realm); BehaviorProblem.find(realm.letter + self.letters); end
  def behavior_problems; Realm.all.collect{|realm| self + realm}; end

  def manic?; %w{e p}.include?(problem_letter); end

end
