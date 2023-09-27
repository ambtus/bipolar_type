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
  def generics; behaviors.map(&:generic_behavior); end
  def realms; behaviors.map(&:realm); end

  def generic_behavior; (GenericBehavior.all - generics).first; end

  def css(behavior)
    return "chosen" if behaviors.include?(behavior)
    return "constrained" if realms.include?(behavior.realm)
    return "constrained" if generics.include?(behavior.generic_behavior)
    return "free"
  end

  def free?(behavior); css(behavior) == "free"; end

  def paths(behavior); [behavior_paths, behavior.symbol].join; end
  def next(behavior); "#{question.next}:#{paths(behavior)}"; end


  def type_path; finished? && behaviors.sort.map(&:realm).map(&:symbol).values_at(2,3,0,1).join; end


end
