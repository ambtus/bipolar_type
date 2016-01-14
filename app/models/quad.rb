class Quad < Phrase

  def self.my_path; Realm.all.map(&:path).join; end
  def self.first; Quad.send my_path; end

  def initialize(string)
    @path = string
    @realms = string.scan(/./).collect{|r| Realm.send(r)}.uniq
    @realms.check_constraints Realm, 4, 4
    super(@realms)
  end
  attr_reader :realms, :path

  def subtypes; realms.add(Attitude.all); end

  def self.paths; Realm.all.permutation(4).collect{|array| array.map(&:path).join}; end
  ALL = self.paths.collect{|path| self.new(path)}
  def self.all; ALL; end
  ALL.each {|quad| define_singleton_method(quad.path) {quad} }

  def discover_without(subtype)
    raise unless subtypes.include? subtype
    "Q4_#{subtypes.without(subtype).map(&:path).join}"
  end

  def inspect; subtypes.join("•").to_word; end
  def name; realms.map(&:name).join("•").to_word; end

end
