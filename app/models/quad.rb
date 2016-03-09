class Quad < Phrase

  def self.my_path; Attitude.all.join; end
  def self.first; Quad.send my_path; end

  def initialize(string)
    @path = string
    @attitudes = string.scan(/../).collect{|a| Attitude.send(a)}
    @attitudes.check_constraints Attitude, 4, 4
    super(@attitudes)
  end
  attr_reader :attitudes, :path

  def subtypes; attitudes.add(Realm.all); end

  def self.paths; Attitude.all.repeated_permutation(4).collect{|array| array.map(&:path).join}; end
  ALL = self.paths.collect{|path| self.new(path)}
  def self.all; ALL; end
  ALL.each {|quad| define_singleton_method(quad.path) {quad} }

  def discover_without(subtype)
    raise unless subtypes.include? subtype
    "Q4_#{subtypes.without(subtype).map(&:path).join}"
  end

  def names; subtypes; end
  def inspect; names.join("•"); end
  def name; inspect; end

end
