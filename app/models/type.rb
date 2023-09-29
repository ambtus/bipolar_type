class Type

  def self.my_path; "AFMP"; end
  def self.my_type; self.new my_path; end

  def initialize(string)
    @symbol = string
    @realms = string.scan(/./).collect{|x| Realm.send(x)}
    @realms.check_constraints Realm, 4, 4
  end
  attr_reader :symbol, :realms

  ALL = Realm::SYMBOLS.permutation(4).collect{|x| new(x.join)}
  def self.all; self::ALL; end

  def behaviors; realms.add(Phase.all); end

  def mbtis; behaviors.map(&:mbti).join("•"); end
  def inspect; @symbol; end

  def name; behaviors.map(&:symbol).join("•"); end

  def less_behavior(behavior); behaviors.map(&:less).find{|b| b.phase == behavior.phase}; end
  def more_behavior(behavior); behaviors.map(&:more).find{|b| b.phase == behavior.phase}; end
  def instead_behavior(behavior); behaviors.map(&:instead).find{|b| b.phase == behavior.phase}; end
end

