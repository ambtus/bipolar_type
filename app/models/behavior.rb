class Behavior < Concept

  def initialize(string)
    @symbol = string
    @cycle = Cycle.send(string.first)
    @realm = Realm.send(string.second)
    @cycle_type = CycleType.send(string.third)
  end
  attr_reader :symbol, :cycle, :realm, :cycle_type

  ALL = CycleBehavior::SYMBOLS.collect do |cb|
          Realm::SYMBOLS.collect do |realm|
            self.new [cb.first, realm, cb.second].join
          end
        end.flatten
  def self.all; self::ALL; end
  def self.each(&block);self::ALL.each(&block); end
  ALL.each{|s| define_singleton_method(s.symbol) {s}}

  def description; [cycle.verb, realm.adjective, cycle_type.noun].to_phrase; end
  def underscored; description.gsub(" ", "_"); end
  def name; underscored.camelcase; end

end
