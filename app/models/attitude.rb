class Attitude < Phrase

  def initialize(array)
    array.check_constraints Indexable, 2, 2
    @sensitivity = array.first
    @order = array.second
    super
  end
  attr_reader :sensitivity, :order

  def to_s; words.join("X"); end
  def to_str; words.join("X"); end
  def inspect; words.join("X").to_word; end
  def name; inspect; end
  def path; words.map(&:path).join("X"); end

  def subtypes; Subtype.all.select{|s| s.attitude == self}; end

  ALL = Sensitivity::ALL.collect do |sensitivity|
          Order::ALL.collect do |order|
            self.new [sensitivity,order]
          end
        end.flatten
  def self.all; ALL; end
  ALL.each{|subtype| define_singleton_method(subtype.path) {subtype}}

  def self.paths; all.map(&:path); end

  def result(realm)
    case path
    when "eXe", "iXi"
      realm.potentials.many_phrase
    when "eXi", "iXe"
      realm.potentials.few_phrase
    end
  end

end
