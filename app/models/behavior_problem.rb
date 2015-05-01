class BehaviorProblem
  LETTERS = (Realm::LETTERS.product(AttitudeProblem::LETTERS)).map(&:join)

  def initialize(string)
    raise "#{string} isn't a BehaviorProblem" unless LETTERS.include?(string)
    @index = LETTERS.index(string)
    @letters = string
    @realm_letter = string[0]
    @behavior_letters = string[0,2]
    @attitude_letter = string[1]
    @attitude_problem_letters = string[1,2]
  end
  attr_reader :letters, :realm_letter, :behavior_letters, :attitude_letter, :attitude_problem_letters

  BEHAVIOR_PROBLEMS = LETTERS.collect{|choice| BehaviorProblem.new(choice)}
  def self.all; BEHAVIOR_PROBLEMS; end

  def self.find(letters); BEHAVIOR_PROBLEMS[LETTERS.index(letters)]; end

  def realm; Realm.find(realm_letter); end
  def behavior; Behavior.find(behavior_letters); end
  def attitude; Attitude.find(attitude_letter); end
  def attitude_problem; AttitudeProblem.find(attitude_problem_letters); end

  delegate :manic?, :problem, :solution, to: :attitude_problem

  def mbti; [realm.mbti, attitude_problem.mbti].join.mbti_order; end

end
