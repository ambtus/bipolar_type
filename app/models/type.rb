class Type

  def self.my_path; "UAE•GMS•UFS•GPE"; end
  def self.my_type; self.new my_path; end

  def initialize(string)
    @symbol = string
    parts = string.split("•")
    @behaviors = parts[0,4].collect{|x| Behavior.send(x)}
    @behaviors.check_constraints Behavior, 4, 4
    @realms = @behaviors.map(&:realm)
    @realms.check_constraints Realm, 4, 4
    @phases = @behaviors.map(&:phase)
    @phases.check_constraints Phase, 4, 4
    @avian = Avian.send(parts.last) rescue Avian.derive_from(@realms)
  end
  attr_reader :behaviors, :realms, :phases, :avian

  def inspect; [*@behaviors, @avian].map(&:symbol).join("•"); end
  def name; inspect; end

  def by_phase; Phase.all.collect{|p| behaviors.find{|b| b.phase == p}}; end

  def goal(behavior); [behavior.opposite, behavior.balancer, behavior.displacer, behavior][@behaviors.index(behavior)]; end

  %w{first second third fourth}.each_with_index do |priority, index|
     define_method(priority) {behaviors[index]}
  end

  def all_firsts; [first, second].map(&:balancer) + [third, fourth].map(&:displacer); end
  def firsts(behavior); all_firsts.select{|b| b.phase == behavior.phase}; end

  def all_seconds; [first, second].map(&:displacer) + [third, fourth].map(&:balancer); end
  def seconds(behavior); all_seconds.select{|b| b.phase == behavior.phase}; end

  def all_thirds; behaviors.map(&:opposite); end
  def thirds(behavior); all_thirds.find{|b| b.phase == behavior.phase}; end

  def mbtis; behaviors.map(&:mbti).join("•"); end

  def other_function; behaviors.without(first).find{|b| b.noun == first.noun}.realm.mbti; end
  def mbti_possibilities; [first.mbti.insert(1,other_function), first.mbti.insert(2,other_function)]; end
  def mbti_closest; mbti_possibilities.find{|x| x.is_mbti?}; end
  def mbti_prefix; mbti_closest ? mbti_closest + ": " : ""; end

  def months(phase); avian.months(phase); end

end

