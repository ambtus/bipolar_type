class TypeProblem
  def self.my_path; "eppijeij"; end
  def self.first; new(my_path); end

  def initialize(string)
    @letters = string
  end
  attr_reader :letters

  def attitude_problems; letters.scan(/../).collect{|ap| AttitudeProblem.find(ap)}; end
  def attitudes; attitude_problems.map(&:attitude); end
  def behavior_problems; attitude_problems.add(Realm.all); end
  def behaviors; behavior_problems.map(&:behavior); end
  def type; Type.find(attitudes.map(&:letter).join); end
  def mbtis; type.mbtis; end

  def mbti; behavior_problems.map(&:mbti).join("-"); end

  def without_behavior_letters(behavior_problem); (behaviors - [behavior_problem.behavior]).map(&:letters).join; end
  def discover_path_without_behavior(behavior_problem); "Q4_#{without_behavior_letters(behavior_problem)}" ;end

  def without_problem_letters(behavior_problem); (behaviors + (behavior_problems - [behavior_problem])).map(&:letters).join; end
  def discover_path_without_problem(behavior_problem); "Q8_#{without_problem_letters(behavior_problem)}" ;end

  def manic_behaviors; behavior_problems[0,2]; end
  def hypomanic_behaviors; [behavior_problems.first, behavior_problems.third]; end
  def dysthymic_behaviors; [behavior_problems.second, behavior_problems.fourth]; end
  def depressed_behaviors; behavior_problems[2,2]; end

  private
  def method_missing(method, *args, &block)
    type.send(method, *args, &block)
  end

end
