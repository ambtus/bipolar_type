class Answer

  def self.first_path; "Q1"; end
  def self.first; Answer.new(first_path); end

  def self.jump_path(*behaviors); "Q#{behaviors.size + 1}:#{behaviors.map(&:symbol).join('•')}"; end

  def initialize(string)
    @question,@behavior_paths,@preferences_path = string.split(":")
    @behavior_paths = @behavior_paths || ""
    @preferences_path = @preferences_path || ""
  end

  def number; @question.chip.to_i ; end
  def index; number - 1; end
  def finished?; number > 3; end

  def behaviors; @behavior_paths.split('•')[0,4].collect{|x| Behavior.send(x)}.reverse; end
  def available_realms; Realm.all - behaviors.map(&:realm); end
  def available_phases; Phase.all - behaviors.map(&:phase); end

  def available_behaviors; available_phases.multiply(available_realms); end

  def all_behaviors; behaviors + available_behaviors.flatten; end
  def ones; [
all_behaviors.find{|b| Phase.UE == b.phase}, all_behaviors.find{|b| Phase.GS == b.phase}]; end
  def twos; [
all_behaviors.find{|b| Phase.GE == b.phase}, all_behaviors.find{|b| Phase.US == b.phase}];  end

  def paths(behavior)
    if @behavior_paths.empty?
      behavior.symbol
    else
      [@behavior_paths, behavior.symbol].join('•')
    end
  end
  def next(behavior); "#{@question.next}:#{paths(behavior)}"; end

  def type_path; all_behaviors.map(&:symbol).join('•'); end

end
