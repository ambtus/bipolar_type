class Answer

  def self.first_path; "Q1"; end
  def self.first; Answer.new(first_path); end

  def self.jump_path(*behaviors); "Q#{behaviors.size + 1}:#{behaviors.map(&:symbol).join}"; end

  def initialize(string)
    @question,@behavior_paths = string.split(":")
    @behavior_paths = @behavior_paths || ""
  end
  attr_reader :question, :behavior_paths

  def number; @question.last.to_i ; end
  def index; number - 1; end
  def finished?; number > 4; end

  def behaviors; @behavior_paths.scan(/.../).collect{|x| Behavior.send(x)}; end
  def phases; behaviors.map(&:phase); end
  def realms; behaviors.map(&:realm); end

  def phase; (Phase.all - phases).first; end

  def css(behavior)
    return "chosen" if behaviors.include?(behavior)
    return "constrained" if realms.include?(behavior.realm)
    return "constrained" if phases.include?(behavior.phase)
    return "available"
  end

  def free?(behavior); css(behavior) == "available"; end

  def paths(behavior); [behavior_paths, behavior.symbol].join; end
  def next(behavior); "#{question.next}:#{paths(behavior)}"; end


  def type_path; finished? && behaviors.sort.map(&:realm).map(&:symbol).join; end


end
