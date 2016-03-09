class Subtype < Phrase

  def initialize(array)
    @realm = array.first
    @attitude = array.second
    super
  end
  attr_reader :realm, :attitude

  def sort_order; [realm, attitude]; end
  def <=>(other); sort_order <=> other.sort_order; end

  ALL = Attitude::ALL.collect do |attitude|
          Realm::ALL.collect do |realm|
            self.new [realm,attitude]
          end
        end.flatten
  def self.all; ALL; end
  def words; [attitude.first, realm, attitude.second]; end
  def inspect; Word.new words.join.upcase; end
  def to_s; inspect.to_s; end
  def to_str; to_s; end

  def path; to_s; end
  ALL.each{|s| define_singleton_method(s.path) {s}}
  def self.paths; ALL.map(&:path); end

  def peers; ALL.select{|s| s.realm == realm }; end
  def discover_path; Answer.first.next(self); end

  def same_realm; ALL.select{|s| s.realm == realm}; end

  def method_missing(meth, *arguments, &block)
    if attitude.respond_to?(meth)
      attitude.send(meth, *arguments, &block)
    elsif realm.respond_to?(meth)
      realm.send(meth, *arguments, &block)
    else
      super
    end
  end

  def problem; Phrase.new ["too", quantity, potential ]; end
  def bad_behave; Phrase.new [modifier, behave, amount]; end
  def short; "I have #{problem} because I #{optional_do} #{bad_behave}"; end

  def optional_do; "do" if index > 1; end
  def modifier; "not" if index > 1; end
  def amount; index > 1 ? "enough" : "too much"; end
  def alt_amount; index > 1 ? "less" : "more"; end
  def desired; index > 1 ? "continue" : "stop"; end

  def behave; [0,3].include?(index) ? consume : produce; end
  def alt_behave; [0,3].include?(index) ? produce : consume; end

  def quantity; index.odd? ? potential.few : potential.many; end
  def bad_episode; index.odd? ? "mania" : "depression"; end
  def bad_episoding; index.odd? ? "manic" : "depressed"; end
  def drugs; index.odd? ? "sedatives" : "stimulants"; end
  def good_episoding; index.odd? ? "depressed" : "manic"; end
  def bad_change;index.odd? ? "loss" : "gain"; end
  def good_change; index.odd? ? "gain" : "loss"; end

  def advice
    case index
    when 0, 1
      "wait as long as you can before you start"
    when 2,3
      "#{behave} as often as you can"
    end
  end
end
