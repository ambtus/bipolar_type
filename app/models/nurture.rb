class Nurture

  def self.first_path; "Q1"; end
  def self.first; new(first_path); end

  def self.jump_path(behaviors); "Q1:#{behaviors.reverse.map(&:symbol).join('•')}"; end

  def initialize(string)
    @question,@behavior_paths,@preferences_path = string.split(":")
    @behavior_paths = @behavior_paths || ""
    @preferences_path = @preferences_path || ""
  end

  def number; @question.chip.to_i ; end
  def index; number - 1; end
  def finished?; number > 4; end

  def behaviors; @behavior_paths.split('•')[0,4].collect{|x| Behavior.send(x)}; end
  def preferences; @preferences_path.split('•')[0,4].collect{|x| Behavior.send(x)}; end

  def available_behaviors; behaviors - preferences; end

  def all_behaviors; preferences + available_behaviors; end

  def paths(behavior)
    behaviors.without(behavior).map(&:symbol).join('•') + ":" + preferences.push(behavior).map(&:symbol).join('•')
  end
  def next(behavior); "#{@question.next}:#{paths(behavior)}"; end

  def type_path; all_behaviors.map(&:symbol).join('•'); end

end
