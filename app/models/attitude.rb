class Attitude < Phrase

  def initialize(array)
    array.check_constraints Indexable, 2, 2
    @preference = array.first
    @order = array.second
    super
  end
  attr_reader :preference, :order

  def to_s; words.join("X"); end
  def to_str; words.join("X"); end
  def inspect; words.join("X").to_word; end
  def name; inspect; end
  def path; to_s; end

  def subtypes; Subtype.all.select{|s| s.attitude == self}; end

  ALL = Preference::ALL.collect do |preference|
          Order::ALL.collect do |order|
            self.new [preference,order]
          end
        end.flatten
  def self.all; ALL; end
  ALL.each{|subtype| define_singleton_method(subtype.to_s) {subtype}}

  def self.paths; all.map(&:path); end

end
