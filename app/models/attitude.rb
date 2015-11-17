class Attitude < Phrase

  def initialize(array)
    array.check_constraints Transition, 2, 2
    @breaks = array.first
    @accelerator = array.second
    super
  end
  attr_reader :breaks, :accelerator

  def to_s; words.join("X"); end
  def to_str; words.join("X"); end
  def inspect; words.join("X").to_word; end
  def name; inspect; end
  def path; to_s; end

  def subtypes; Subtype.all.select{|s| s.attitude == self}; end

  ALL = Breaks::ALL.collect do |breaks|
          Accelerator::ALL.collect do |accelerator|
            self.new [breaks,accelerator]
          end
        end.flatten
  def sort_order; [breaks, accelerator]; end
  def <=>(other); sort_order <=> other.sort_order; end
  def self.all; ALL.sort; end
  ALL.each{|subtype| define_singleton_method(subtype.to_s) {subtype}}

  def self.paths; all.map(&:path); end

end
