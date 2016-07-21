class Type

  def self.my_path; Realm.paths.join; end
  def self.first; self.send my_path; end

  def initialize(string)
    @path = string
    @realms = @path.scan(/./).collect{|a| Realm.send(a)}
    @realms.uniq.check_constraints Realm, 4, 4
  end
  attr_reader :realms, :path
  def inspect; @realms.map(&:inspect).join; end

  def subtypes; @realms.add(Attitude.all); end

  def self.paths; Realm.all.permutation(4).collect{|a| a.map(&:path).join}; end
  ALL = self.paths.collect{|path| self.new(path)}
  def self.all; ALL; end
  ALL.each {|type| define_singleton_method(type.path) {type} }

  def name; realms.map(&:symbol).join("•"); end
end
