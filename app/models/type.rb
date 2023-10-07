class Type

  def self.my_path; Time.now.dst? ? 'UAE•GMS•UFS•GPE•AN' : 'UAE•GMS•UFS•GPE•BN' ; end
  def self.my_type; self.new my_path; end

  def initialize(string)
    parts = string.split('•')
    @natures = parts[0,4].collect{|x| Behavior.send(x)}
    @natures.check_constraints Behavior, 4, 4
    @realms = @natures.map(&:realm)
    @realms.check_constraints Realm, 4, 4
    @phases = @natures.map(&:phase)
    @phases.check_constraints Phase, 4, 4
    avians = parts[4].chars rescue Avian.derive_from(@realms)
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

  def nurtures; [first, second].map(&:balancer) + [third, fourth].map(&:displacer); end
  def firsts(behavior); nurtures.select{|b| b.phase == behavior.phase}; end

  def all_seconds; [first, second].map(&:displacer) + [third, fourth].map(&:balancer); end
  def seconds(behavior); all_seconds.select{|b| b.phase == behavior.phase}; end

  def all_thirds; natures.map(&:opposite); end
  def thirds(behavior); all_thirds.find{|b| b.phase == behavior.phase}; end

  def mbtis; natures.map(&:mbti).join('•'); end

  def other_function; natures.without(first).find{|b| b.noun == first.noun}.realm.mbti; end
  def mbti_possibilities; [first.mbti.insert(1,other_function), first.mbti.insert(2,other_function)]; end
  def mbti_closest; mbti_possibilities.find{|x| x.is_mbti?}; end
  def mbti_prefix; mbti_closest ? mbti_closest + ': ' : ''; end

  def all_by_priority; nurtures + all_seconds + all_thirds + natures; end
  def all_get_energy; all_by_priority.select{|b| b.phase == Phase.first}; end
  def all_use_strength; all_by_priority.select{|b| b.phase == Phase.third}; end

end

