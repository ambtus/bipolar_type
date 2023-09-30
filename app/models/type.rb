class Type

  def self.my_path; "UAEGMSGPEUFS"; end
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

  def less_behavior(behavior); behaviors.map(&:less).find{|b| b.phase == behavior.phase}; end
  def more_behavior(behavior); behaviors.map(&:more).find{|b| b.phase == behavior.phase}; end
  def instead_behavior(behavior); behaviors.map(&:instead).find{|b| b.phase == behavior.phase}; end

  def mbtis; behaviors.map(&:mbti).join("•"); end
  def mbti; behaviors.first.mbti + behaviors.second.realm.mbti; end
end

