class Subtype < Phrase

  def initialize(array)
    @starting = array.first
    @energy = array.second
    @stopping = array.third
    super
  end
  attr_reader :starting, :energy, :stopping

  # Override phrase spaces
  def to_s; words.join(""); end
  def to_str; words.join(""); end
  def inspect; words.join("").to_word; end
  def parenthetical; inspect.parenthetical; end
  def discover_path; Answer.first.next(self); end

  ALL = Starting::ALL.collect do |starting|
               Energy::ALL.collect do |energy|
                 Stopping::ALL.collect do |stopping|
                   self.new [starting,energy,stopping]
                 end
               end
             end.flatten
  def ordered_words; [starting, stopping, energy]; end
  def <=>(other); ordered_words <=> other.ordered_words; end
  def self.all; ALL.sort; end
  def self.find(string); ALL.find{|s| s.to_s == string}; end

  def same_energy; ALL.select{|s| s.energy == energy}; end
  def attitude; [starting, stopping]; end
  def same_attitude; ALL.select{|s| s.attitude == attitude}; end
  def partial; attitude.join; end

  def name; Phrase.new [descriptive_name, parenthetical]; end

  def signals; "#{energy.realm.capitalize} Signals"; end
  def descriptive_name
    case partial
    when "ee"
      "External #{signals}"
    when "ei"
      "Positive #{signals}"
    when "ie"
      "Negative #{signals}"
    when "ii"
      "Internal #{signals}"
    end
  end

  def why_start; starting.why(energy); end
  def i_start; "I start #{consume.ing} when #{why_start.period}" end

  def why_stop; stopping.why(energy); end
  def i_stop; "I stop #{consume.ing} when #{why_stop.period}" end

  def method_missing(meth, *arguments, &block)
    energy.send(meth, *arguments, &block)
  end

end
