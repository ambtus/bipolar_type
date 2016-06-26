class Type < Phrase

  def self.my_path; Realm.paths.join; end
  def self.first; self.send my_path; end

  def initialize(string)
    @path = string
    @realms = string.scan(/./).collect{|a| Realm.send(a)}
    @realms.uniq.check_constraints Realm, 4, 4
    @subtypes = @realms.add(Nature.all)
    super @subtypes.map(&:path)
  end
  attr_reader :realms, :subtypes, :path

  def self.paths; Realm.all.permutation(4).map(&:join); end
  ALL = self.paths.collect{|path| self.new(path)}
  def self.all; ALL; end
  ALL.each {|type| define_singleton_method(type.path) {type} }

  def name; subtypes.map(&:symbol).join("•"); end

end
