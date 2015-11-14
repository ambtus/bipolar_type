class Subtype < Phrase

  def initialize(array)
    @losing = array.first
    @energy = array.second
    @gaining = array.third
    super
  end
  attr_reader :losing, :energy, :gaining

  # Override phrase spaces
  def to_s; words.join(""); end
  def to_str; words.join(""); end
  def inspect; words.join("").to_word; end

  ALL = Losing::ALL.collect do |losing|
               Energy::ALL.collect do |energy|
                 Gaining::ALL.collect do |gaining|
                   self.new [losing,energy,gaining]
                 end
               end
             end.flatten
  def ordered_words; [energy, losing, gaining]; end
  def <=>(other); ordered_words <=> other.ordered_words; end
  def self.all; ALL.sort; end
  def self.find(string); ALL.find{|s| s.to_s == string}; end

  def same_energy; ALL.select{|s| s.energy == energy}; end
  def attitude; [gaining, losing]; end
  def same_attitude; ALL.select{|s| s.attitude == attitude}; end

  def name; words.map(&:name).join.to_word; end

  delegate :gain, :lose, :potential, to: :energy, :prefix => true
  delegate :ease_of, to: :gaining, :prefix => true
  delegate :ease_of, to: :losing, :prefix => true

  def when_empty; losing.when_empty(energy); end
  def size; losing.size(energy); end

  def when_full; gaining.when_full(energy); end
  def sensitivity; gaining.sensitivity(energy); end

end
