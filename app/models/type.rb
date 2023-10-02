class Type

  def self.my_path; "UAEGMSUFSGPE"; end
  def self.my_type; self.new my_path; end

  def initialize(string)
    @symbol = string
    @behaviors = string.scan(/.../).collect{|x| Behavior.send(x)}
    @behaviors.check_constraints Behavior, 4, 4
    @realms = @behaviors.map(&:realm)
    @realms.check_constraints Realm, 4, 4
    @phases = @behaviors.map(&:phase)
    @phases.check_constraints Phase, 4, 4
  end
  attr_reader :behaviors, :realms, :phases

  def inspect; @behaviors.map(&:symbol).join("•"); end
  def name; inspect; end

  def by_phase; Phase.all.collect{|p| behaviors.find{|b| b.phase == p}}; end

  %w{dominant auxiliary tertiary inferior}.each_with_index do |priority, index|
     define_method(priority) {behaviors[index]}
  end

  def all_firsts; [dominant, auxiliary].map(&:balancer) + [tertiary, inferior].map(&:displacer); end
  def firsts(behavior); all_firsts.select{|b| b.phase == behavior.phase}; end

  def all_seconds; [dominant, auxiliary].map(&:displacer) + [tertiary, inferior].map(&:balancer); end
  def seconds(behavior); all_seconds.select{|b| b.phase == behavior.phase}; end

  def all_thirds; behaviors.map(&:opposite); end
  def thirds(behavior); all_thirds.find{|b| b.phase == behavior.phase}; end

  def mbtis; behaviors.map(&:mbti).join("•"); end

  def other_function; behaviors.without(dominant).find{|b| b.noun == dominant.noun}.realm.mbti; end
  def mbti_possibilities; [dominant.mbti.insert(1,other_function), dominant.mbti.insert(2,other_function)]; end
  def mbti_closest; mbti_possibilities.find{|x| x.is_mbti?}; end
  def mbti_prefix; mbti_closest ? mbti_closest + ": " : ""; end
end

