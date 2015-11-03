class Pair

  LETTERS = %w{i e}.multiply(Realm::LETTERS[1,4].multiply(Subtype::LETTERS).flatten).flatten.reject{|x| x[1,2] == x[4,2]}

  def initialize(letters)
    raise "#{letters} isn't a Pair" unless LETTERS.include?(letters)
    @index = LETTERS.index(letters)
    @path = letters
  end
  attr_reader :path

  PAIRS = LETTERS.collect{|letters| Pair.new(letters)}
  def self.all; PAIRS; end
  def self.find(letters); PAIRS[LETTERS.index(letters)]; end

  def problem; Subtype.find(path[3,3]); end
  def reason; Realm.find(path[1,2]) + problem.attitude.opposite; end
  def subtypes; [problem, reason]; end

  def behavior2; path.first == "i" ? "input" : "output"; end
  def behavior; path.first == "i" ? "output" : "input"; end

  def reason_state; path.first == "i" ? reason.high : reason.low; end

  def name; [problem.tendency, reason_state].map(&:capitalize).join(" and "); end

  def reason_advice; path.first == "e" ? "start #{reason.gain1.ing}" : "stop #{reason.act.ing}"; end
  def problem_advice; path.first == "e" ? "stop #{problem.gain1.ing}" : "start #{problem.act.ing}"; end

  def advices; [problem_advice, reason_advice]; end

  def realms; subtypes.map(&:realm); end
  def other_realms; Realm.all - realms; end

  def alts; other_realms.map(&:subtypes).flatten; end
  def possibles; Pair.all.reject{|p| (p.realms & realms).present?}; end

  def reverse; Pair.find(path.first + problem.realm.path + reason.path); end

  def other_behavior_path; path.first == "i" ? "e" : "i"; end
  def opposite; Pair.find(other_behavior_path + reason.realm.path + problem.opposite.path); end

end
