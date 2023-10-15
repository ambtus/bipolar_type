class Nature

  def self.first_path; "Q1"; end
  def self.first; new(first_path); end

  def self.jump_path(*behaviors); "Q#{behaviors.size + 1}:#{behaviors.map(&:symbol).join('•')}"; end

  def initialize(string)
    @question,@behavior_paths = string.split(":")
    @behavior_paths = @behavior_paths || ""
  end

  def number; @question.chip.to_i ; end
  def index; number - 1; end
  def finished?; number > 4; end

  def behaviors; @behavior_paths.split('•')[0,4].collect{|x| Behavior.send(x)}; end
  def available_realms; Realm.all - behaviors.map(&:realm); end
  def realm; available_realms.sample; end

  def paths(behavior)
    if @behavior_paths.empty?
      behavior.symbol
    else
      [@behavior_paths, behavior.symbol].join('•')
    end
  end
  def next(behavior); "#{@question.next}:#{paths(behavior)}"; end

  def type_path; behaviors.sort.map(&:symbol).join('•'); end

end
