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
    @problem_letter = string[2]
  end
  attr_reader :letters, :realm_letter, :behavior_letters, :attitude_letter, :attitude_problem_letters, :problem_letter

  BEHAVIOR_PROBLEMS = LETTERS.collect{|choice| BehaviorProblem.new(choice)}
  def self.all; BEHAVIOR_PROBLEMS; end

  def self.find(letters); BEHAVIOR_PROBLEMS[LETTERS.index(letters)]; end

  def realm; Realm.find(realm_letter); end
  def behavior; Behavior.find(behavior_letters); end
  def attitude; Attitude.find(attitude_letter); end
  def attitude_problem; AttitudeProblem.find(attitude_problem_letters); end

  delegate :manic?, :problem, :solution, to: :attitude_problem
  delegate :realm_adjective, to: :behavior

  def wing_behavior; Behavior.find(realm.letter + problem_letter); end
  def problem_behavior; BehaviorProblem.find(realm.letter + problem.letters); end
  def solution_behavior; BehaviorProblem.find(realm.letter + solution.letters); end

  def mbti; [realm.mbti, attitude_problem.mbti].join.mbti_order; end

  def generic; [realm.short, attitude_problem.short].join(" "); end
  def short; "#{generic}: #{aka}"; end
  def with_mbti; "(#{mbti})"; end
  def short_with_mbti; [short, with_mbti].join(" "); end
  def generic_with_mbti; [generic, with_mbti].join(" "); end
  def aka_with_mbti; [aka, with_mbti].join(" "); end

  def aka
    case mbti.upcase
    when "ETJ"
      "buy many cheap things"
    when "ETP"
      "buy a few expensive things"
    when "ITJ"
      "do many small jobs"
    when "ITP"
      "do a few large jobs"
    when "ESJ"
      "take many short walks"
    when "ESP"
      "take a few long walks"
    when "ISJ"
      "eat many small meals"
    when "ISP"
      "eat a few large meals"
    when "EFJ"
      "tell many short stories"
    when "EFP"
      "tell a few long stories"
    when "IFJ"
      "hear a lot of short stories and songs"
    when "IFP"
      "hear a few long novels and concerts"
    when "ENJ"
      "solve many small problems"
    when "ENP"
      "solve a few large problems"
    when "INJ"
      "analyze many small problems"
    when "INP"
      "analzye a few large problems"
    end
  end

end
