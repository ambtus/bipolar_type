class Answer

  def self.first_path; "Q1"; end
  def self.first; Answer.new(first_path); end

  def self.jump_path(*behaviors); "Q#{behaviors.size + 1}:#{behaviors.map(&:symbol).join('•')}"; end

  def initialize(string)
    @question,@behavior_paths,@preference_paths = string.split(":")
    @behavior_paths = @behavior_paths || ""
    @preference_paths = @preference_paths || ""
  end

  def number; @question.chip.to_i ; end
  def index; number - 1; end
  def natured?; number > 4; end
  def nurtured?; number > 8; end

  def behaviors; @behavior_paths.split('•')[0,4].collect{|x| Behavior.send(x)}; end
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

  def preferences; @preference_paths.split('•')[0,4].collect{|x| Behavior.send(x)}; end

  def paths(behavior)
    if natured?
      behaviors.without(behavior).map(&:symbol).join('•') + ":" + preferences.push(behavior).map(&:symbol).join('•')
    else
      [@behavior_paths, behavior.symbol].join('•')
    end
  end
  def next(behavior); "#{@question.next}:#{paths(behavior)}"; end

  def type_path; preferences.map(&:symbol).join('•'); end

end
