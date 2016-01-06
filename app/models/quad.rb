class Quad < Phrase

  def self.my_path; "espenjifpitj"; end
  def self.first; Quad.send my_path; end

  def initialize(string)
    @subtypes = string.scan(/.../).collect{|s| Subtype.send(s)}
    @realms = @subtypes.map(&:realm).uniq
    @realms.check_constraints Realm, 4, 4
    super(@subtypes)
  end
  attr_reader :realms, :subtypes
  def path; super.downcase; end

#  def subtypes; realms.add(Attitude.all); end

  def self.paths
    Attitude.all.repeated_permutation(4).collect do |attitudes|
      Realm.all.add(attitudes).sort.map(&:path).join
    end
  end
  ALL = self.paths.collect{|path| self.new(path)}
  def self.all; ALL; end
  ALL.each {|quad| define_singleton_method(quad.path) {quad} }

  def discover_without(subtype)
    raise unless subtypes.include? subtype
    "Q4_#{subtypes.without(subtype).map(&:path).join}"
  end

  def inspect; subtypes.join("•").to_word; end
  def name; inspect; end

end
