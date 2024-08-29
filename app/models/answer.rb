class Answer

  def self.first_path; 'Q1'; end
  def self.first; Answer.new(first_path); end

  def initialize(string)
    @path = string
    @question,problem_string = @path.split(':')
    @problem_string = problem_string || ''
  end
  attr_reader :question, :path, :problem_string

  def number; @question.last.to_i ; end
  def index; number - 1; end
  def finished?; number > 3; end

  def problems; @problem_string.scan(/.../).collect{|s| Behavior.send(s)}; end
  def quadrants; problems.map(&:quadrant); end
  def free; Quadrant.all - quadrants; end
  def free?(problem); free.include?(problem.quadrant); end

  def next(choice); question.next + ':' + @problem_string + choice; end

  def first; free.add([Realm.f, Realm.n]); end
  def second; free.add([Realm.n, Realm.f]); end
  def pair; [first, second]; end

  def realms; problems.map(&:realm); end
  def unused; free.first + Realm.all.without(realms).first; end

  def all; (problems + [unused]).map(&:flop); end

  def type_path;all.sort.map(&:realm).map(&:path).join; end

end
