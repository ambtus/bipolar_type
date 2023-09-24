class Answer

  def self.first_path; "Q1"; end
  def self.first; Answer.new(first_path); end

  def initialize(string)
    @question,@behavior_paths = string.split(":")
    @behavior_paths = @behavior_paths || ""
  end
  attr_reader :question, :behavior_paths

  def number; @question.last.to_i ; end
  def index; number - 1; end
  def finished?; number > 4; end

  def behaviors; @behavior_paths.scan(/.../).collect{|s| Behavior.send(s)}.sort; end

  def realm_taken?(realm); behaviors.map(&:realm).include?(realm); end
  def behavior_taken?(generic_behavior); behaviors.map(&:generic_behavior).include?(generic_behavior); end
  def taken?(behavior); realm_taken?(behavior.realm) || behavior_taken?(behavior.generic_behavior); end

  def css(behavior)
    return "chosen" if behaviors.include?(behavior)
    return "constrained" if taken?(behavior)
    return "free"
  end


  def paths(behavior); [behavior_paths, behavior.symbol].join; end
  def next(behavior); "#{question.next}:#{paths(behavior)}"; end

  def type_path; behaviors.map(&:realm).map(&:symbol).join; end


end
