class Type

  def self.my_path; Time.now.dst? ? 'UAE•GMS•UFS•GPE•AA' : 'UAE•GMS•UFS•GPE•BA' ; end
  def self.my_type; self.new my_path; end

  def initialize(string)
    parts = string.split('•')
    @natures = parts[0,4].collect{|x| Behavior.send(x)}.sort
    @natures.check_constraints Behavior, 4, 4
    @realms = @natures.map(&:realm)
    @realms.check_constraints Realm, 4, 4
    @phases = @natures.map(&:phase)
    @phases.check_constraints Phase, 4, 4
    avians = parts[4].chars rescue Array.new(2,Avian.average.symbol)
    @hours = Hours.send avians.first
    @months = Months.send avians.second
    set_symbol
  end
  attr_reader :symbol, :natures, :realms, :phases, :hours, :months

  def inspect; @symbol; end
  def name; inspect; end

  def set_symbol; @symbol = [*natures.map(&:symbol), [@hours, @months].map(&:symbol).join].join('•'); end

  def set_hours(avian); @hours = avian; set_symbol; end
  def set_months(avian); @months = avian; set_symbol;end

  def months_range(phase); months.range(phase); end
  def hours_range(phase); hours.range(phase); end


  def by_phase; Phase.all.collect{|p| natures.find{|b| b.phase == p}}; end

  def goal(behavior); [behavior.opposite, behavior.balancer, behavior.displacer, behavior][@natures.index(behavior)]; end

  %w{first second third fourth}.each_with_index do |priority, index|
     define_method(priority) {natures[index]}
  end

  def balancer(behavior); natures.map(&:balancer).find{|b| b.phase == behavior.phase}; end
  def displacer(behavior); natures.map(&:displacer).find{|b| b.phase == behavior.phase}; end
  def opposite(behavior); natures.map(&:opposite).find{|b| b.phase == behavior.phase}; end

  def mbtis; natures.map(&:mbti).join('•'); end

  def other_function; natures.without(first).find{|b| b.noun == first.noun}.realm.mbti; end
  def mbti_possibilities; [first.mbti.insert(1,other_function), first.mbti.insert(2,other_function)]; end
  def mbti_closest; mbti_possibilities.find{|x| x.is_mbti?}; end
  def mbti_prefix; mbti_closest ? mbti_closest + ': ' : ''; end

end

