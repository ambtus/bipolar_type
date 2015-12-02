class Quad < Phrase

  def self.my_path; "nstf"; end
  def self.first; Quad.new my_path; end

  def initialize(string)
    @realms = string.scan(/./).collect{|s| Realm.send(s)}
    @realms.check_constraints Realm, 4, 4
    super(@realms)
  end
  attr_reader :realms
  def path; super.downcase; end

  def self.paths; Realm.paths.permutation(4).map(&:join); end
  ALL = self.paths.collect{|path| self.new(path)}
  def self.all; ALL; end
  ALL.each {|quad| define_singleton_method(quad.path) {quad} }

  def subtypes; realms.add(Attitude.all); end

  def inspect; subtypes.join("•").to_word; end
  def name; inspect; end

end
